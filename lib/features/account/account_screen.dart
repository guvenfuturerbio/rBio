import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'account_vm.dart';

class AccountScreen extends StatefulWidget {
  bool isDefault;

  AccountScreen({
    this.isDefault = true,
  });

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final homeKey = GlobalKey<ScaffoldState>();
  LoadingDialog loadingDialog;

  void didPopNext() {
    imageCache.clearLiveImages();
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountScreenVm>(
      create: (context) => AccountScreenVm(context),
      child: Consumer<AccountScreenVm>(
        builder: (BuildContext context, AccountScreenVm vm, Widget child) {
          return Scaffold(
            body: kIsWeb
                ? Padding(
                    padding: EdgeInsets.only(
                        left: Atom.size.width < 800
                            ? Atom.size.width * 0.03
                            : Atom.size.width * 0.10,
                        right: Atom.size.width < 800
                            ? Atom.size.width * 0.03
                            : Atom.size.width * 0.10),
                    child: _builBody(context, vm),
                  )
                : _builBody(context, vm),
          );
        },
      ),
    );
  }

  Widget _builBody(BuildContext context, AccountScreenVm vm) {
    if (vm.status == LoadingStatus.done) {
      return _buildPosts(context, vm.userAccount, vm);
    } else {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(R.color.dark_blue),
        ),
      );
    }
  }

  Widget _buildPosts(
    BuildContext context,
    UserAccount userAccount,
    AccountScreenVm vm,
  ) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton<Locale>(
                hint: Text(LocaleProvider.of(context).select_language +
                    ": " +
                    vm.currentLocale),
                items: LocaleProvider.delegate.supportedLocales
                    .map((Locale value) {
                  return new DropdownMenuItem<Locale>(
                    value: value,
                    child: new Text(value.languageCode.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  vm.changeCountryCode(value.languageCode);
                },
              ),

              //
              getNoImageAvatar(context, vm),

              //
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  userAccount.name + " " + userAccount.surname,
                  style: TextStyle(
                      color: R.color.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),

              //
              Container(
                child: widget.isDefault
                    ? null
                    : Utils.instance.button(
                        text: LocaleProvider.of(context)
                            .switch_back_to_default_account,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return GuvenAlert(
                                backgroundColor: Colors.white,
                                title: GuvenAlert.buildTitle(
                                    LocaleProvider.of(context).warning),
                                actions: [
                                  GuvenAlert.buildMaterialAction(
                                    LocaleProvider.of(context).Ok,
                                    () {
                                      vm.changeUserToDefault(context);
                                    },
                                  ),
                                ],
                                content: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GuvenAlert.buildDescription(
                                        LocaleProvider.of(context)
                                            .relative_change_message,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),

              //
              _ButtonDetail(
                image: SvgPicture.asset(R.image.ic_user),
                text: LocaleProvider.of(context).lbl_personal_information,
                onTap: () {
                  AnalyticsManager()
                      .sendEvent(PersonalInformationTabClickEvent());
                  Atom.to(PagePaths.PERSONAL_INFORMATION);
                },
              ),

              //
              _ButtonDetail(
                image: SvgPicture.asset(R.image.ic_password),
                text: LocaleProvider.of(context).change_password,
                onTap: () {
                  Atom.to(PagePaths.CHANGE_PASSWORD);
                },
              ),

              //
              _ButtonDetail(
                image: SvgPicture.asset(R.image.ic_relatives),
                text: LocaleProvider.of(context).kids,
                onTap: () {
                  AnalyticsManager().sendEvent(MyRelativesTabClickEvent());
                  Atom.to(PagePaths.RELATIVES);
                },
              ),

              //
              _ButtonDetail(
                image: SvgPicture.asset(R.image.ic_all_files_grey),
                text: LocaleProvider.of(context).all_appointment_file,
                onTap: () {
                  Atom.to(PagePaths.ALL_FILES);
                },
              ),

              //
              // Visibility(
              //   visible: vm.isYoutubeVisible,
              //   child: _ButtonDetailCustom(
              //     image: SvgPicture.asset(R.image.ic_live_broadcast),
              //     text: LocaleProvider.of(context).youtube_stream,
              //     left: 16,
              //     right: 25,
              //     onTap: () {
              //       vm.navigateToYoutubeViewer(context);
              //     },
              //   ),
              // ),

              //
              Visibility(
                visible: false,
                child: _ButtonDetail(
                  image: SvgPicture.asset(R.image.ic_bookmark_news),
                  text: LocaleProvider.of(context).symptom_analyzer,
                  onTap: () {
                    Atom.to(PagePaths.ADASYMPTOMANALYZER);
                  },
                ),
              ),

              //
              Visibility(
                visible: false,
                child: _ButtonDetail(
                  image: SvgPicture.asset(R.image.ic_comment_news),
                  text: LocaleProvider.of(context).guven_journal,
                  onTap: () {
                    Atom.to(
                      PagePaths.WEBVIEW,
                      queryParameters: {
                        'url': LocaleProvider.of(context).guven_journal_url,
                        'title': LocaleProvider.of(context).guven_journal,
                      },
                    );
                  },
                ),
              ),

              //
              _ButtonDetail(
                image: SvgPicture.asset(R.image.ic_logout_grey),
                text: LocaleProvider.of(context).log_out,
                onTap: () {
                  vm.logout(context);
                },
              ),

              //
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getNoImageAvatar(BuildContext context, AccountScreenVm vm) {
    return CustomCircleAvatar(
        child: GestureDetector(
          onTap: () {
            if (!kIsWeb) {
              Atom.to(
                PagePaths.PROFILEIMAGEVIEWER,
                queryParameters: {
                  'title': Uri.encodeFull(
                      LocaleProvider.of(context).profile_picture_name),
                  'imagePath': ''
                },
              );
            }
          },
          child: vm.mobileFilePath.isEmpty
              ? SvgPicture.asset(
                  R.image.profile_avatar,
                  fit: BoxFit.fill,
                )
              : kIsWeb
                  ? PhotoView(imageProvider: MemoryImage(vm.imageBytes))
                  : PhotoView(
                      imageProvider: FileImage(File(vm.mobileFilePath))),
        ),
        size: 120);
  }

  Widget _ButtonDetail({Widget image, String text, Function onTap}) =>
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 32),
        child: InkWell(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3,
            child: Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  image,
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    width: 1,
                    height: 30,
                    color: R.color.dark_white,
                  ),
                  Expanded(
                      child: Text(
                    text,
                    style: TextStyle(color: R.color.black, fontSize: 18),
                  )),
                  Container(
                    child: SvgPicture.asset(R.image.ic_arrow_right),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
      title: LocaleProvider.of(context).title_user_profile,
    );
  }
}
