import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/profile_vm.dart';

class ProfileScreen extends StatelessWidget {
  final bool isFromDashboard;
  const ProfileScreen({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileVm>(
      create: (context) => ProfileVm(context)..getNumbers(),
      child: ProfileView(isFromDashboard: isFromDashboard),
    );
  }
}

class ProfileView extends StatelessWidget {
  final bool isFromDashboard;

  const ProfileView({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileVm>(
      builder: (BuildContext context, ProfileVm vm, Widget? child) {
        return RbioStackedScaffold(
          isLoading: vm.showProgressOverlay,
          appbar: _buildAppBar(context),
          body: _buildBody(vm, context),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      leading: isFromDashboard ? const SizedBox() : null,
      leadingWidth: isFromDashboard ? 0 : null,
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

  Widget _buildBody(ProfileVm vm, BuildContext context) {
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
                name: getIt<UserNotifier>().getCurrentUserNameAndSurname(),
                imageBytes: getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.profileImage),
                leadingImage: UserLeadingImage.circle,
                onTap: () {},
                width: Atom.width,
              ),

              if (getIt<IAppConfig>().functionality.relatives)
                if (!(context.read<UserNotifier>().isDefaultUser ?? true)) ...[
                  RbioElevatedButton(
                    title: LocaleProvider.of(context)
                        .switch_back_to_default_account,
                    onTap: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],

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
                        context,
                        LocaleProvider.current.healthcare_employee,
                        () {
                          Atom.to(PagePaths.doctorHome);
                        },
                      ),
                    ],

                    if (getIt<IAppConfig>().functionality.relatives)
                      _buildListItem(
                        context,
                        LocaleProvider.current.relatives,
                        () {
                          Atom.to(PagePaths.relatives);
                        },
                      ),

                    //
                    _buildListItem(
                      context,
                      LocaleProvider.current.lbl_personal_information,
                      () {
                        Atom.to(PagePaths.personalInformation);
                      },
                    ),
                    //

                    getIt<IAppConfig>().functionality.chronicTracking
                        ? _buildListItem(
                            context,
                            LocaleProvider.current.health_information,
                            () {
                              Atom.to(PagePaths.healthInformation);
                            },
                          )
                        : const SizedBox(),

                    if (!Atom.isWeb &&
                        getIt<UserNotifier>().isCronic &&
                        getIt<IAppConfig>().functionality.chronicTracking)
                      _buildListItem(
                        context,
                        LocaleProvider.current.devices,
                        () {
                          Atom.to(PagePaths.devices);
                        },
                      ),

                    //
                    if (getIt<IAppConfig>().platform.checkMedimender())
                      _buildListItem(
                        context,
                        LocaleProvider.current.reminders,
                        () {
                          Atom.to(PagePaths.reminderList);
                        },
                      ),

                    //
                    _buildListItem(
                      context,
                      LocaleProvider.current.change_password,
                      () {
                        Atom.to(PagePaths.changePassword);
                      },
                    ),

                    if (getIt<IAppConfig>().functionality.magazines) ...[
                      _buildListItem(
                        context,
                        LocaleProvider.current.magazines,
                        () {
                          Atom.to(PagePaths.magazinselection);
                        },
                      )
                    ],

                    //
                    _buildListItem(
                      context,
                      LocaleProvider.current.request_and_suggestions,
                      () {
                        Atom.to(PagePaths.suggestResult);
                      },
                    ),

                    //
                    _buildListItem(
                      context,
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
    BuildContext context,
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
