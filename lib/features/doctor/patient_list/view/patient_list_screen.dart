import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/patient_list_vm.dart';

// ignore: must_be_immutable
class DoctorPatientListScreen extends StatelessWidget {
  DoctorPatientListScreen({Key key}) : super(key: key);

  // #region AtomParams
  PatientType type;
  // #endregion

  final bigFlex = 40;
  final smallFlex = 25;

  @override
  Widget build(BuildContext context) {
    try {
      type = Atom.queryParameters['type'].xPatientType;
    } catch (_) {
      return RbioRouteError();
    }

    return KeyboardDismissOnTap(
      child: ChangeNotifierProvider<DoctorPatientListVm>(
        create: (context) => DoctorPatientListVm(context, type),
        child: RbioScaffold(
          appbar: _buildAppBar(context),
          body: Consumer<DoctorPatientListVm>(
            builder: (
              BuildContext context,
              DoctorPatientListVm vm,
              Widget child,
            ) {
              return _buildBody(context, vm);
            },
          ),
        ),
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.bg_measurement_tracking,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat_icon,
              isDark: false,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );
  // #endregion

  // #region _buildBody
  Widget _buildBody(BuildContext context, DoctorPatientListVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildPatients(context, vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
  // #endregion

  // #region _buildPatients
  Widget _buildPatients(BuildContext context, DoctorPatientListVm vm) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildSearchFilterBar(context, vm),

          //
          SizedBox(height: 8),

          //
          Expanded(
            child: _buildListView(vm),
          ),
        ],
      );
  // #endregion

  // #region _buildSearchFilterBar
  Widget _buildSearchFilterBar(BuildContext context, DoctorPatientListVm vm) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: R.sizes.borderRadiusCircular,
                color: getIt<ITheme>().cardBackgroundColor,
              ),
              child: RbioTextFormField(
                hintText: '${LocaleProvider.current.search}...',
                onChanged: (text) {
                  vm.textOnChanged(text);
                },
              ),
            ),
          ),

          //
          SizedBox(width: 6),

          //
          Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: PopupMenuButton<String>(
              elevation: 0,
              color: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: getIt<ITheme>().cardBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  LocaleProvider.current.sort_by,
                  style: context.xHeadline5.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: RbioOverlayMenu(
                      tiles: [...vm.getFilterPopupList(vm, context)],
                      margin: EdgeInsets.only(top: 50),
                      color: getIt<ITheme>().cardBackgroundColor,
                      borderRadius: R.sizes.borderRadiusCircular,
                      separator: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildListView
  Widget _buildListView(DoctorPatientListVm vm) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: vm.filterList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTypeCard(context, vm.filterList[index]);
      },
    );
  }
  // #endregion

  // #region _buildTypeCard
  Widget _buildTypeCard(BuildContext context, dynamic model) {
    switch (type) {
      case PatientType.BloodGlucose:
        return R.sizes.textScaleBuilder(
          context,
          smallWidget: _buildGlucoseCard(context, model, false),
          largeWidget: _buildGlucoseCard(context, model, true),
        );

      case PatientType.Weight:
        return R.sizes.textScaleBuilder(
          context,
          smallWidget: _buildBMICard(context, model, false),
          largeWidget: _buildBMICard(context, model, true),
        );

      case PatientType.BloodPressure:
        return SizedBox();

      default:
        return SizedBox();
    }
  }
  // #endregion

  // #region _buildGlucoseCard
  Widget _buildGlucoseCard(
    BuildContext context,
    DoctorGlucosePatientModel model,
    bool isLarge,
  ) {
    if (isLarge) {
      return _buildLargeCard(
        context,
        onTap: () => _bloodGlucoseOnTap(model),
        name: model.name,
        dates: model.measurements
            .map(
              (item) => Expanded(
                child: _buildSmallCardText(
                  context,
                  item.measurementTime != null
                      ? DateTime.parse(item.measurementTime ?? '')
                          .xFormatTime7()
                      : '',
                ),
              ),
            )
            .toList(),
        times: model.measurements
            .map(
              (item) => Expanded(
                child: _buildSmallCardText(
                  context,
                  item.measurementTime != null
                      ? DateTime.parse(item.measurementTime ?? '')
                          .xFormatTime8()
                      : '',
                ),
              ),
            )
            .toList(),
        values: model.measurements
            .map(
              (item) => Expanded(
                child: _buildColorfulText(
                  true,
                  context,
                  '${item.measurement}',
                  _getMeasurementBackcolor(
                    text: item.measurement,
                    item: model,
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return _buildSmallCard(
        context,
        onTap: () => _bloodGlucoseOnTap(model),
        name: model.name,
        dates: model.measurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildSmallCardText(
                  context,
                  item.measurementTime != null
                      ? DateTime.parse(item.measurementTime ?? '')
                          .xFormatTime7()
                      : '',
                ),
              ),
            )
            .toList(),
        times: model.measurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildSmallCardText(
                  context,
                  item.measurementTime != null
                      ? DateTime.parse(item.measurementTime ?? '')
                          .xFormatTime8()
                      : '',
                ),
              ),
            )
            .toList(),
        values: model.measurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildColorfulText(
                  false,
                  context,
                  '${item.measurement}',
                  _getMeasurementBackcolor(
                    text: item.measurement,
                    item: model,
                  ),
                ),
              ),
            )
            .toList(),
      );
    }
  }
  // #endregion

  // #region _bloodGlucoseOnTap
  void _bloodGlucoseOnTap(DoctorGlucosePatientModel model) {
    Atom.to(
      PagePaths.BLOOD_GLUCOSE_PATIENT_DETAIL,
      queryParameters: {
        'patientId': model.id.toString(),
        'patientName': model.name,
      },
    );
  }
  // #endregion

  // #region _buildBMICard
  Widget _buildBMICard(
    BuildContext context,
    DoctorBMIPatientModel model,
    bool isLarge,
  ) {
    if (isLarge) {
      return _buildLargeCard(
        context,
        onTap: () {},
        name: model.name,
        dates: model.bmiMeasurements
            .map(
              (item) => Expanded(
                child: _buildSmallCardText(
                  context,
                  item.occurrenceTime != null
                      ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime7()
                      : '',
                ),
              ),
            )
            .toList(),
        times: model.bmiMeasurements
            .map(
              (item) => Expanded(
                child: _buildSmallCardText(
                  context,
                  item.occurrenceTime != null
                      ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime8()
                      : '',
                ),
              ),
            )
            .toList(),
        values: model.bmiMeasurements
            .map(
              (item) => Expanded(
                child: _buildColorfulText(
                  true,
                  context,
                  '${item.weight}',
                  Colors.red,
                ),
              ),
            )
            .toList(),
      );
    } else {
      return _buildSmallCard(
        context,
        onTap: () {},
        name: model.name,
        dates: model.bmiMeasurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildSmallCardText(
                  context,
                  item.occurrenceTime != null
                      ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime7()
                      : '',
                ),
              ),
            )
            .toList(),
        times: model.bmiMeasurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildSmallCardText(
                  context,
                  item.occurrenceTime != null
                      ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime8()
                      : '',
                ),
              ),
            )
            .toList(),
        values: model.bmiMeasurements
            .map(
              (item) => Expanded(
                flex: smallFlex,
                child: _buildColorfulText(
                  false,
                  context,
                  '${item.weight}',
                  Colors.red,
                ),
              ),
            )
            .toList(),
      );
    }
  }
  // #endregion

  // #region _buildLargeCard
  Widget _buildLargeCard(
    BuildContext context, {
    @required void Function() onTap,
    @required String name,
    @required List<Widget> dates,
    @required List<Widget> times,
    @required List<Widget> values,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: getIt<ITheme>().cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBigSmallCardText(
                          context,
                          'Hasta Adı',
                          getIt<ITheme>().textColorPassive,
                        ),

                        //
                        _buildBigSmallCardText(
                          context,
                          name,
                          getIt<ITheme>().textColorSecondary,
                        ),
                      ],
                    ),
                  ),

                  //
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      RbioBadge(
                        isBigSize: false,
                        image: R.image.clock_icon,
                      ),

                      //
                      SizedBox(width: 8),

                      //
                      RbioBadge(
                        isBigSize: false,
                        image: R.image.chat_icon,
                      ),
                    ],
                  ),
                ],
              ),

              //
              SizedBox(height: 8),

              //
              Row(
                children: dates,
              ),

              //
              Row(
                children: times,
              ),

              //
              Row(
                children: values,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildSmallCard
  Widget _buildSmallCard(
    BuildContext context, {
    @required void Function() onTap,
    @required String name,
    @required List<Widget> dates,
    @required List<Widget> times,
    @required List<Widget> values,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: getIt<ITheme>().cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          flex: bigFlex,
                          child: _buildBigSmallCardText(
                            context,
                            'Hasta Adı',
                            getIt<ITheme>().textColorPassive,
                          ),
                        ),

                        //
                        ...dates,
                      ],
                    ),

                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          flex: bigFlex,
                          child: _buildBigSmallCardText(
                            context,
                            name,
                            getIt<ITheme>().textColorSecondary,
                          ),
                        ),

                        //
                        ...times,
                      ],
                    ),

                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          flex: bigFlex,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //
                              Expanded(
                                child: RbioBadge(
                                  isBigSize: false,
                                  image: R.image.clock_icon,
                                ),
                              ),

                              //
                              Spacer(),

                              //
                              Expanded(
                                child: RbioBadge(
                                  isBigSize: false,
                                  image: R.image.chat_icon,
                                ),
                              ),

                              //
                              Spacer(),
                            ],
                          ),
                        ),

                        //
                        ...values,
                      ],
                    ),
                  ],
                ),
              ),

              //
              SvgPicture.asset(
                R.image.right_arrow,
                width: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _getMeasurementBackcolor
  Color _getMeasurementBackcolor({
    String text,
    DoctorGlucosePatientModel item,
  }) {
    return text == '' || text == null
        ? getIt<ITheme>().cardBackgroundColor
        : Utils.instance.fetchMeasurementColor(
            measurement: _textToInt(text ?? ""),
            criticMin: item?.alertMin?.toInt() ?? 0,
            criticMax: item?.alertMax?.toInt() ?? 0,
            targetMax: item?.normalMax?.toInt() ?? 0,
            targetMin: item?.normalMin?.toInt() ?? 0,
          );
  }
  // #endregion

  // #region _textToInt
  int _textToInt(String text) {
    if (text == null) {
      return 0;
    } else if (text.length > 0) {
      return int.parse(text);
    } else {
      return 0;
    }
  }
  // #endregion

  // #region _buildBigSmallCardText
  Widget _buildBigSmallCardText(
      BuildContext context, String text, Color color) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.xHeadline4.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  // #endregion

  // #region _buildSmallCardText
  Widget _buildSmallCardText(BuildContext context, String text) {
    return Center(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline5,
      ),
    );
  }
  // #endregion

  // #region _buildColorfulText
  Widget _buildColorfulText(
    bool isLarge,
    BuildContext context,
    String text,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Spacer(
          flex: isLarge ? 1 : 10,
        ),

        //
        Expanded(
          flex: 15,
          child: Container(
            color: color,
            alignment: Alignment.center,
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline4,
            ),
          ),
        ),

        //
        Spacer(
          flex: isLarge ? 1 : 10,
        ),
      ],
    );
  }
  // #endregion
}
