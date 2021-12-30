import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../body_parts_paint.dart';
import '../viewmodel/symptoms_body_locations_page_vm.dart';

class SymptomsBodyLocationsScreen extends StatefulWidget {
  SymptomsBodyLocationsScreen({Key key}) : super(key: key);

  @override
  _SymptomsBodyLocationsScreenState createState() =>
      _SymptomsBodyLocationsScreenState();
}

class _SymptomsBodyLocationsScreenState
    extends State<SymptomsBodyLocationsScreen> {
  int selectedGenderId;
  String yearOfBirth;
  bool isFromVoice;

  State state;
  final notifier = ValueNotifier(Offset.zero);
  String bodyPart = '';

  @override
  Widget build(BuildContext context) {
    try {
      selectedGenderId = int.parse(Atom.queryParameters['selectedGenderId']);
      yearOfBirth = Atom.queryParameters['yearOfBirth'];
      isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<SymptomsBodyLocationsVm>(
      create: (context) => SymptomsBodyLocationsVm(
        context: context,
        isFromVoice: isFromVoice,
        notifierFromPage: notifier,
        selectedGenderIdFromPage: selectedGenderId,
        yearOfBirth: yearOfBirth,
      ),
      child: Consumer<SymptomsBodyLocationsVm>(
        builder: (
          BuildContext context,
          SymptomsBodyLocationsVm value,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).my_symptoms,
              ),
            ),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SymptomsBodyLocationsVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return Column(
          children: [
            //
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 25, top: 25),
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
                        color: getIt<ITheme>().mainColor),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleProvider.of(context).complaint_body_part,
                    style: context.xHeadline3,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),

            //
            value.selectedBodyLocation == null ||
                    value.selectedBodyLocation.name == ''
                ? Container(margin: EdgeInsets.only(top: 20), child: Text(' '))
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                        LocaleProvider.of(context).choice +
                            value.selectedBodyLocation.name,
                        style: context.xHeadline3),
                  ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: GestureDetector(
                  onTapDown: (e) {
                    value.notifier.value = e.localPosition;
                    print(e.localPosition);
                  },
                  child: CustomPaint(
                    painter: BodyPartsPainter(
                      isGenderMale:
                          selectedGenderId == 0 || selectedGenderId == 2
                              ? true
                              : false,
                      clickedPathFunc: (myValue) {
                        //print(myValue);
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) async {
                          if (myValue != null) {
                            await value.selectedBodyLocationFetch(
                                value.getLocationsName(myValue));
                          } else {
                            await value.selectedBodyLocationFetch(null);
                          }
                        });
                      },
                      notifier: value.notifier,
                      bodyLocations: value.bodyLocations,
                    ),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ),

            //
            Visibility(
              visible: value.selectedBodyLocation != null &&
                      value.selectedBodyLocation.name != ''
                  ? true
                  : false,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: RbioElevatedButton(
                    onTap: () async {
                      RbioConfig.of(context).bodyLocationRsp =
                          value.selectedBodyLocation;
                      Atom.to(
                        PagePaths.SYMPTOM_SUB_BODY_LOCATIONS,
                        queryParameters: {
                          'selectedGenderId': selectedGenderId.toString(),
                          'yearOfBirth': yearOfBirth,
                          'isFromVoice': false.toString(),
                        },
                      ); /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BodySubLocationsPage(
                            selectedBodyLocation: value.selectedBodyLocation,
                            selectedGenderId: widget.selectedGenderId,
                            yearOfBirth: widget.yearOfBirth,
                            isFromVoice: widget.isFromVoice,
                          ),
                        ),
                      );*/
                    },
                    title: LocaleProvider.of(context).continue_lbl,
                  ),
                ),
              ),
            ),

            //
            Spacer(flex: 1),
          ],
        );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
}
