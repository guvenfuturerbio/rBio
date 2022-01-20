import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/profile_vm.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

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
      builder: (BuildContext context, ProfileVm vm, Widget child) {
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
            R.image.change_size_icon,
            color: getIt<ITheme>().iconSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ProfileVm vm) {
    switch (vm.state) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              R.sizes.stackedTopPadding(context),
              R.sizes.hSizer8,

              //
              RbioLocaleDropdown(),

              //
              RbioUserTile(
                name: Utils.instance.getCurrentUserNameAndSurname,
                imageBytes: getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.PROFILE_IMAGE),
                leadingImage: UserLeadingImage.Circle,
                onTap: () {},
                width: Atom.width,
              ),

              //
              _buildVerticalGap(),

              //
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: getIt<ITheme>().cardBackgroundColor,
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
                          Atom.to(PagePaths.DOCTOR_HOME);
                        },
                      ),
                    ],

                    //
                    _buildListItem(
                      LocaleProvider.current.lbl_personal_information,
                      () {
                        Atom.to(PagePaths.PERSONAL_INFORMATION);
                      },
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.health_information,
                      () {
                        Atom.to(PagePaths.HEALTH_INFORMATION);
                      },
                    ),

                    if (!Atom.isWeb && getIt<UserNotifier>().isCronic)
                      _buildListItem(
                        LocaleProvider.current.devices,
                        () {
                          Atom.to(PagePaths.DEVICES);
                        },
                      ),

                    //
                    if (getIt<AppConfig>().mediminder)
                      _buildListItem(
                        LocaleProvider.current.reminders,
                        () {
                          Atom.to(PagePaths.MEDIMINDER_INITIAL);
                        },
                      ),

                    //
                    _buildListItem(
                      LocaleProvider.current.change_password,
                      () {
                        Atom.to(PagePaths.CHANGE_PASSWORD);
                      },
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.request_and_suggestions,
                      () {
                        Atom.to(PagePaths.SUGGEST_REQUEST);
                      },
                      isDivider: false,
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

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
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
            padding: EdgeInsets.symmetric(
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
                  R.image.ic_arrow_right,
                  width: R.sizes.iconSize5,
                ),
              ],
            ),
          ),
        ),

        //
        if (isDivider)
          Divider(
            thickness: 0,
            indent: 10,
            endIndent: 10,
            height: 0.0,
          ),
      ],
    );
  }
}
