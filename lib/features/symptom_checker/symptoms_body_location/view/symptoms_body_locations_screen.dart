import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../body_parts_paint.dart';
import '../viewmodel/symptoms_body_locations_page_vm.dart';

class SymptomsBodyLocationsScreen extends StatefulWidget {
  const SymptomsBodyLocationsScreen({Key? key}) : super(key: key);

  @override
  _SymptomsBodyLocationsScreenState createState() =>
      _SymptomsBodyLocationsScreenState();
}

class _SymptomsBodyLocationsScreenState
    extends State<SymptomsBodyLocationsScreen> {
  int? selectedGenderId;
  String? yearOfBirth;
  bool? isFromVoice;

  State? state;
  final notifier = ValueNotifier(Offset.zero);
  String? bodyPart = '';

  @override
  Widget build(BuildContext context) {
    try {
      selectedGenderId =
          int.parse(Atom.queryParameters['selectedGenderId'] as String);
      yearOfBirth = Atom.queryParameters['yearOfBirth'];
      isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<SymptomsBodyLocationsVm>(
      create: (context) => SymptomsBodyLocationsVm(
        context: context,
        notifierFromPage: notifier,
        selectedGenderIdFromPage: selectedGenderId,
        yearOfBirth: yearOfBirth,
      ),
      child: Consumer<SymptomsBodyLocationsVm>(
        builder: (
          BuildContext context,
          SymptomsBodyLocationsVm value,
          Widget? child,
        ) {
          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).my_symptoms,
      ),
    );
  }

  Widget _buildBody(BuildContext context, SymptomsBodyLocationsVm value) {
    switch (value.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 25, top: 25),
                      child: Text(
                        selectedGenderId == 0
                            ? LocaleProvider.of(context).gender_male
                            : selectedGenderId == 1
                                ? LocaleProvider.of(context).gender_female
                                : selectedGenderId == 2
                                    ? LocaleProvider.of(context).boy
                                    : LocaleProvider.of(context).girl,
                        style: context.xHeadline1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getIt<IAppConfig>().theme.mainColor),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        LocaleProvider.of(context).complaint_body_part,
                        style: context.xHeadline3,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        (value.selectedBodyLocation == null ||
                                value.selectedBodyLocation!.name == '')
                            ? ''
                            : LocaleProvider.of(context).choice +
                                value.selectedBodyLocation!.name!,
                        style: context.xHeadline3,
                      ),
                    ),

                    //
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        child: GestureDetector(
                          onTapDown: (e) {
                            value.notifier!.value = e.localPosition;
                            LoggerUtils.instance.i(e.localPosition);
                          },
                          child: CustomPaint(
                            painter: BodyPartsPainter(
                              isGenderMale:
                                  selectedGenderId == 0 || selectedGenderId == 2
                                      ? true
                                      : false,
                              clickedPathFunc: (myValue) {
                                //LoggerUtils.instance.i(myValue);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) async {
                                  if (myValue != null) {
                                    await value.selectedBodyLocationFetch(
                                        value.getLocationsName(myValue)!);
                                  } else {
                                    await value.selectedBodyLocationFetch(null);
                                  }
                                });
                              },
                              notifier: value.notifier,
                              bodyLocations: value.bodyLocations,
                            ),
                            child: SizedBox(
                              height: Atom.height * 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //
            Visibility(
              visible: value.selectedBodyLocation != null &&
                      value.selectedBodyLocation!.name != ''
                  ? true
                  : false,
              child: RbioElevatedButton(
                onTap: () async {
                  getIt<IAppConfig>()
                      .platform
                      .adjustManager
                      ?.trackEvent(MySymptomsPage2Event());
                  getIt<FirebaseAnalyticsManager>().logEvent(
                    SikayetlerimSayfa2DevamEvent(
                      getIt<UserNotifier>().firebaseEmail.toString(),
                      selectedGenderId.toString(),
                      yearOfBirth.toString(),
                      value.selectedBodyLocation?.name.toString(),
                    ),
                  );

                  AppInheritedWidget.of(context)?.bodyLocationRsp =
                      value.selectedBodyLocation;
                  Atom.to(
                    PagePaths.symptomSubBodyLocations,
                    queryParameters: {
                      'selectedGenderId': selectedGenderId.toString(),
                      'yearOfBirth': yearOfBirth!,
                      'isFromVoice': false.toString(),
                    },
                  );
                },
                title: LocaleProvider.of(context).continue_lbl,
                infinityWidth: true,
              ),
            ),
            R.sizes.defaultBottomPadding,
          ],
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
