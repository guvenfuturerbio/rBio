import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/dashboard/guven/home/cubit/cubit/home_screen_cubit.dart';

import '../../../../core/core.dart';

class GuvenHomeScreen extends StatelessWidget {
  const GuvenHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(userManager: getIt()),
      child: const GuvenHomeView(),
    );
  }
}

class GuvenHomeView extends StatefulWidget {
  const GuvenHomeView({Key? key}) : super(key: key);

  @override
  _GuvenHomeViewState createState() {
    return _GuvenHomeViewState();
  }
}

class _GuvenHomeViewState extends State<GuvenHomeView> {
  @override
  Widget build(BuildContext context) {
    context.read<HomeScreenCubit>().getUser();
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) =>
      BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loadInProgress: () => const RbioLoading(),
            success: () => Scaffold(
              appBar: RbioAppBar(
                context: context,
                leading: const SizedBox(),
              ),
              body: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            LocaleProvider.of(context).lbl_hello +
                                " " +
                                getIt<UserFacade>().getNameAndSurname(),
                            style: TextStyle(
                              color: getIt<IAppConfig>().theme.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),

                        //
                        Container(
                          child: Text(
                            LocaleProvider.of(context).lbl_take_care,
                            style: TextStyle(
                              color: getIt<IAppConfig>().theme.gray,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 20,
                            right: 120,
                          ),
                        ),

                        //
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Atom.to(
                                PagePaths.createAppointment,
                                queryParameters: {
                                  'forOnline': true.toString(),
                                  'fromSearch': false.toString(),
                                  'fromSymptom': false.toString(),
                                },
                              );
                            },
                            child: _itemFindHospital(
                              context: context,
                              title: LocaleProvider.of(context).online_appo,
                              image: R.image.icVideoIcon,
                              number:
                                  LocaleProvider.of(context).title_appointment,
                              colorLeft:
                                  getIt<IAppConfig>().theme.onlineAppointment,
                              colorRight: getIt<IAppConfig>()
                                  .theme
                                  .lightOnlineAppointment,
                              margin: const EdgeInsets.only(top: 10),
                            ),
                          ),
                        ),

                        //
                        InkWell(
                          child: _itemFindHospital(
                              context: context,
                              title:
                                  LocaleProvider.of(context).lbl_find_hospital,
                              image: R.image.icHospitalWhite,
                              colorLeft: getIt<IAppConfig>().theme.red,
                              colorRight: getIt<IAppConfig>().theme.lightRed,
                              number: LocaleProvider.of(context)
                                  .lbl_number_hospital,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10)),
                          onTap: () {
                            getIt<FirebaseAnalyticsManager>().logEvent(
                                MenuElementTiklamaEvent(
                                    'hastane_randevusu_olustur'));
                            Atom.to(
                              PagePaths.createAppointment,
                              queryParameters: {
                                'forOnline': false.toString(),
                                'fromSearch': false.toString(),
                                'fromSymptom': false.toString(),
                              },
                            );
                          },
                        ),

                        //
                        optionsWidget(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            failure: () => const RbioBodyError(),
          );
        },
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          //
          TableRow(
            children: [
              InkWell(
                child: _itemOption(
                  context: context,
                  title: LocaleProvider.of(context).my_appointments,
                  image: R.image.icAppointmentWhite,
                  number: LocaleProvider.of(context).lbl_number_appointment,
                  margin: const EdgeInsetsDirectional.only(
                      top: 10, end: 10, bottom: 10),
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('randevu'));
                  Atom.to(PagePaths.appointment);
                },
              ),
              InkWell(
                child: _itemOption(
                  context: context,
                  title: LocaleProvider.of(context).results,
                  image: R.image.icPriceServices,
                  number: LocaleProvider.of(context).lbl_number_services,
                  margin: const EdgeInsetsDirectional.only(
                      top: 10, start: 10, bottom: 10),
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('sonuclar'));
                  Atom.to(PagePaths.eResult);
                },
              ),
            ],
          ),

          //
          TableRow(
            children: [
              InkWell(
                child: _itemOption(
                  context: context,
                  title: LocaleProvider.of(context).for_you,
                  image: R.image.forYou,
                  number: LocaleProvider.of(context).lbl_number_doctor,
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  isFocused: false,
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('size_ozel'));
                  Atom.to(PagePaths.forYouCategories);
                },
              ),
              InkWell(
                child: _itemOption(
                    context: context,
                    title: LocaleProvider.of(context).request_and_suggestions,
                    image: R.image.icEditWhite,
                    number: LocaleProvider.of(context).lbl_number_doctor,
                    margin: const EdgeInsetsDirectional.only(start: 10)),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('oneriler'));
                  Atom.to(PagePaths.suggestResult);
                },
              ),
            ],
          ),

          //
          const TableRow(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      );

  bool get wantKeepAlive => true;
}

Widget _itemOption({
  required BuildContext context,
  required String title,
  required String image,
  required String number,
  bool isFocused = false,
  required EdgeInsetsDirectional margin,
}) =>
    Container(
      height: 100,
      margin: margin,
      child: ClipRRect(
        borderRadius: R.sizes.borderRadiusCircular,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: getIt<IAppConfig>().theme.textColor,
                  ),
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: 0.5,
                child: SvgPicture.asset(
                  image,
                  width: 60,
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: R.sizes.borderRadiusCircular,
        gradient: LinearGradient(
          colors: isFocused
              ? [
                  getIt<IAppConfig>().theme.red,
                  getIt<IAppConfig>().theme.lightRed,
                ]
              : [
                  getIt<IAppConfig>().theme.gray,
                  getIt<IAppConfig>().theme.grey,
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(5, 10),
          ),
        ],
      ),
    );

Widget _itemFindHospital({
  required BuildContext context,
  required String title,
  required String image,
  required String number,
  required Color colorLeft,
  required Color colorRight,
  required EdgeInsets margin,
}) {
  return context.xTextScaleType == TextScaleType.small
      ? Container(
          height: 100,
          margin: margin,
          padding: const EdgeInsets.only(
            left: 15,
            bottom: 15,
            top: 15,
          ),
          child: ClipRRect(
            borderRadius: R.sizes.borderRadiusCircular,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getIt<IAppConfig>().theme.textColor,
                    ),
                  ),
                ),

                //
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      image,
                      width: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: R.sizes.borderRadiusCircular,
            gradient: LinearGradient(
              colors: [
                colorLeft,
                colorRight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(5, 10),
              ),
            ],
          ),
        )
      : Container(
          height: 150,
          margin: margin,
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          child: ClipRRect(
            borderRadius: R.sizes.borderRadiusCircular,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getIt<IAppConfig>().theme.textColor,
                    ),
                  ),
                ),

                //
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      image,
                      width: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: R.sizes.borderRadiusCircular,
            gradient: LinearGradient(
              colors: [
                colorLeft,
                colorRight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(5, 10),
              ),
            ],
          ),
        );
}
