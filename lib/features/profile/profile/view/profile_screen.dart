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
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(context, LocaleProvider.current.profile),
      ),

      //
      body: Consumer<ProfileVm>(
        builder: (context, value, child) {
          return _buildBody(value);
        },
      ),
    );
  }

  Widget _buildBody(ProfileVm vm) {
    switch (vm.state) {
      case LoadingProgress.DONE:
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: R.sizes.screenPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              RbioUserTile(
                name:
                    '${PatientSingleton().getPatient().firstName} ${PatientSingleton().getPatient().lastName}',
                imageBytes: getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.PROFILE_IMAGE),
                leadingImage: UserLeadingImage.Circle,
                onTap: () {},
                width: Atom.width,
              ),

              //
              Container(
                height: Atom.height * 0.25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNumberTile(
                      vm.numbers?.relatives ?? 0,
                      LocaleProvider.current.kids,
                      () {
                        Atom.to(PagePaths.RELATIVES);
                      },
                    ),
                    _buildHorizontalGap(),
                    _buildNumberTile(
                      vm.numbers?.followers ?? 0,
                      LocaleProvider.current.followers,
                      () {
                        Atom.to(PagePaths.FOLLOWERS);
                      },
                    ),
                    _buildHorizontalGap(),
                    _buildNumberTile(
                      vm.numbers?.subscriptions ?? 0,
                      LocaleProvider.current.subscriptions,
                      () {},
                    ),
                  ],
                ),
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
                    //
                    _buildListItem(
                      LocaleProvider.current.lbl_personal_information,
                      () {},
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.health_information,
                      () {},
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.devices,
                      () {
                        Atom.to(PagePaths.DEVICES);
                      },
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.reminders,
                      () {},
                    ),

                    //
                    _buildListItem(
                      LocaleProvider.current.request_and_suggestions,
                      () {},
                      isDivider: false,
                    ),
                  ],
                ),
              ),

              //
              _buildVerticalGap(),
            ],
          ),
        );

      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.ERROR:
        return RbioError();

      default:
        return SizedBox();
    }
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);

  Widget _buildHorizontalGap() => SizedBox(width: Atom.width * 0.025);

  Widget _buildNumberTile(int number, String title, VoidCallback onTap) {
    return Expanded(
      child: ClipRRect(
        borderRadius: R.sizes.borderRadiusCircular,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //
            Positioned.fill(
              child: Container(
                color: getIt<ITheme>().cardBackgroundColor,
              ),
            ),

            //
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: Atom.width * 0.08,
                backgroundColor: getIt<ITheme>().secondaryColor,
                child: Text(
                  '$number',
                  style: context.xHeadline1.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: Atom.width * 0.020,
                  left: Atom.width * 0.015,
                  right: Atom.width * 0.015,
                ),
                child: Text(
                  title,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),

            //
            Positioned.fill(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String title, VoidCallback onTap,
      {bool isDivider = true}) {
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
                  width: R.sizes.iconSize4,
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
