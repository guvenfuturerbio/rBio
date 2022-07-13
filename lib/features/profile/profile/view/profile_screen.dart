import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final bool isFromDashboard;
  const ProfileScreen({
    Key? key,
    this.isFromDashboard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt<IAppConfig>().platform.sentryManager,
        getIt(),
      ),
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
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) async {
        if (state.status == ProfileStatus.changeUserToDefault) {
          Atom.historyBack();
          Atom.to(PagePaths.main, isReplacement: true, historyState: {});
        } else if (state.status == ProfileStatus.showDefaultErrorDialog) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return RbioMessageDialog(
                description: LocaleProvider.current.sorry_dont_transaction,
                buttonTitle: LocaleProvider.current.ok,
                isAtom: false,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return RbioStackedScaffold(
          isLoading: state.isLoading,
          appbar: _buildAppBar(context),
          body: _buildBody(state, context),
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

  Widget _buildBody(ProfileState state, BuildContext context) {
    switch (state.status) {
      case ProfileStatus.loadingProgress:
        return const RbioLoading();

      case ProfileStatus.success:
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
                name: getIt<UserFacade>().getNameAndSurname(),
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
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<ProfileCubit>(),
                            child: Builder(
                              builder: (context) {
                                return GuvenAlert(
                                  backgroundColor: Colors.white,
                                  title: GuvenAlert.buildTitle(
                                      LocaleProvider.of(context).warning),
                                  actions: [
                                    GuvenAlert.buildMaterialAction(
                                      LocaleProvider.of(context).Ok,
                                      () {
                                        Navigator.pop(context);
                                        context
                                            .read<ProfileCubit>()
                                            .changeUserToDefault();
                                      },
                                    ),
                                  ],
                                  content: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                    if (getIt<UserNotifier>()
                        .user
                        .xGetHealthcareEmployeeOrFalse) ...[
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
                        getIt<UserNotifier>().user.xGetChronicTrackingOrFalse &&
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

              //
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
                      value: state.isTwoFactorAuth,
                      onChanged: (newValue) {
                        context.read<ProfileCubit>().update2FA(newValue);
                      },
                      activeColor: getIt<IAppConfig>().theme.mainColor,
                    ),
                  ],
                ),
              ),

              //
              _buildVerticalGap(),

              //
              RbioElevatedButton(
                title: LocaleProvider.current.log_out,
                onTap: () {
                  context.read<ProfileCubit>().logout(context);
                },
              ),

              //
              R.sizes.defaultBottomPadding,
            ],
          ),
        );

      case ProfileStatus.error:
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
