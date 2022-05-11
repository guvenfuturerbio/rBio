import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/profile_vm.dart';

class ProfileScreen extends StatefulWidget {
  final bool isFromDashboard;

  const ProfileScreen({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) {
        Provider.of<ProfileVm>(context, listen: false).getNumbers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileVm>(
      builder: (BuildContext context, ProfileVm vm, Widget? child) {
        return RbioStackedScaffold(
          isLoading: vm.showProgressOverlay,
          appbar: _buildAppBar(),
          body: _buildBody(vm),
        );
      },
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      leading: widget.isFromDashboard ? const SizedBox() : null,
      leadingWidth: widget.isFromDashboard ? 0 : null,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.profile,
      ),
      actions: [
        //
        IconButton(
          onPressed: () {
            context.read<ThemeNotifier>().changeTextScale();
          },
          icon: SvgPicture.asset(
            R.image.changeSize,
            color: getIt<IAppConfig>().theme.iconSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ProfileVm vm) {
    switch (vm.state) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              R.sizes.stackedTopPadding(context),
              R.sizes.hSizer8,

              //
              const RbioLocaleDropdown(),

              //
              RbioUserTile(
                name: Utils.instance.getCurrentUserNameAndSurname,
                imageBytes: getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.profileImage),
                leadingImage: UserLeadingImage.circle,
                onTap: () {},
                width: Atom.width,
              ),

              //
              _buildVerticalGap(),

              //
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (context.read<UserNotifier>().isDoctor) ...[
                      _buildListItem(
                        LocaleProvider.current.healthcare_employee,
                        () {
                          Atom.to(PagePaths.doctorHome);
                        },
                      ),
                    ],

                    //
                    _buildListItem(
                      LocaleProvider.current.lbl_personal_information,
                      () {
                        Atom.to(PagePaths.personalInformation);
                      },
                    ),
                    //

                    //
                    _buildListItem(
                      LocaleProvider.current.health_information,
                      () {
                        Atom.to(PagePaths.healthInformation);
                      },
                    ),

                    if (!Atom.isWeb && getIt<UserNotifier>().isCronic)
                      _buildListItem(
                        LocaleProvider.current.devices,
                        () {
                          Atom.to(PagePaths.devices);
                        },
                      ),

                    //
                    if (getIt<IAppConfig>().functionality.mediminder)
                      _buildListItem(
                        LocaleProvider.current.reminders,
                        () {
                          Atom.to(PagePaths.reminderList);
                        },
                      ),

                    //
                    _buildListItem(
                      LocaleProvider.current.change_password,
                      () {
                        Atom.to(PagePaths.changePassword);
                      },
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.request_and_suggestions,
                      () {
                        Atom.to(PagePaths.suggestResult);
                      },
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.terms_and_privacy,
                      () {
                        Atom.to(PagePaths.termsAndPrivacy);
                      },
                    ),
                  ],
                ),
              ),

              // 2FA
              R.sizes.hSizer8,
              Padding(
                padding: R.sizes.screenPadding(context).copyWith(top: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: Text(
                        LocaleProvider.of(context).twofa,
                        style: context.xHeadline3,
                      ),
                    ),

                    //
                    CupertinoSwitch(
                      value: vm.isTwoFactorAuth,
                      onChanged: (newValue) {
                        vm.update2FA(newValue);
                      },
                      activeColor: getIt<IAppConfig>().theme.mainColor,
                    ),
                  ],
                ),
              ),

              //
              _buildVerticalGap(),
              RbioElevatedButton(
                title: LocaleProvider.current.log_out,
                onTap: () {
                  vm.logout(context);
                },
              ),

              //
              R.sizes.defaultBottomPadding,
            ],
          ),
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);

  Widget _buildListItem(
    String title,
    VoidCallback onTap, {
    bool isDivider = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  child: Text(
                    title,
                    style: context.xHeadline3,
                  ),
                ),

                //
                SvgPicture.asset(
                  R.image.arrowRight,
                  width: R.sizes.iconSize5,
                ),
              ],
            ),
          ),
        ),

        //
        if (isDivider)
          const Divider(
            thickness: 0,
            indent: 10,
            endIndent: 10,
            height: 0.0,
          ),
      ],
    );
  }
}
