import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/blood_glucose_patient_list_vm.dart';

class BloodGlucosePatientListScreen extends StatefulWidget {
  BloodGlucosePatientListScreen({Key key}) : super(key: key);

  @override
  _BloodGlucosePatientListScreenState createState() =>
      _BloodGlucosePatientListScreenState();
}

class _BloodGlucosePatientListScreenState
    extends State<BloodGlucosePatientListScreen> {
  List items(BloodGlucosePatientListVm vm, BuildContext _context) => [
        GestureDetector(
          child: Container(
            color: getIt<ITheme>().scaffoldBackgroundColor,
            padding: EdgeInsets.all(12),
            child: Text(
              LocaleProvider.of(_context).critical_metrics,
              style: _context.xHeadline4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(_context).pop();
            vm.sortList(DoctorPatientListSortType.criticalMetrics);
          },
        ),
        GestureDetector(
          child: Container(
            color: getIt<ITheme>().scaffoldBackgroundColor,
            padding: EdgeInsets.all(12),
            child: Text(
              LocaleProvider.of(_context).from_newest,
              style: _context.xHeadline4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(_context).pop();
            vm.sortList(DoctorPatientListSortType.fromNewest);
          },
        ),
        GestureDetector(
          child: Container(
            color: getIt<ITheme>().scaffoldBackgroundColor,
            padding: EdgeInsets.all(12),
            child: Text(
              LocaleProvider.of(_context).from_oldest,
              style: _context.xHeadline4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(_context).pop();
            vm.sortList(DoctorPatientListSortType.fromOldest);
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioScaffold(
        appbar: _buildAppBar(),
        body: Consumer<BloodGlucosePatientListVm>(
          builder: (
            BuildContext context,
            BloodGlucosePatientListVm vm,
            Widget child,
          ) {
            return _buildBody(vm);
          },
        ),
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
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

  Widget _buildBody(BloodGlucosePatientListVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildPatients(vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildPatients(BloodGlucosePatientListVm vm) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildSearchFilterBar(vm),

          //
          SizedBox(height: 8),

          //
          Expanded(
            child: _buildList(vm),
          ),
        ],
      );

  Widget _buildSearchFilterBar(BloodGlucosePatientListVm vm) {
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
              child: TextFormField(
                cursorColor: getIt<ITheme>().mainColor,
                style: context.xHeadline5.copyWith(
                  color: getIt<ITheme>().textColorSecondary,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: '${LocaleProvider.current.search}...',
                  hintStyle: context.xHeadline5.copyWith(
                    color: getIt<ITheme>().textColorPassive,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 13, 8, 0),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Center(
                      child: SvgPicture.asset(
                        R.image.search_grey,
                        color: getIt<ITheme>().iconColor,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
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
                      tiles: [...items(vm, context)],
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

  Widget _buildList(BloodGlucosePatientListVm vm) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: vm.filterList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(vm.filterList[index]);
      },
    );
  }

  final bigFlex = 40;
  final smallFlex = 25;
  Widget _buildCard(DoctorPatientModel model) {
    return InkWell(
      onTap: () {
        Atom.to(
          PagePaths.BLOOD_GLUCOSE_PATIENT_DETAIL,
          queryParameters: {
            'patientId': model.id.toString(),
            'patientName': model.name,
          },
        );
      },
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
                            'Hasta Adı',
                            getIt<ITheme>().textColorPassive,
                          ),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('07-12-21'),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('08-12-21'),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('09-12-21'),
                        ),
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
                            model.name,
                            getIt<ITheme>().textColorSecondary,
                          ),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('09:00'),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('15:00'),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildSmallCardText('10:00'),
                        ),
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
                                  image: R.image.attentionSvg,
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
                        Expanded(
                          flex: smallFlex,
                          child: _buildColorfulText('250', R.color.darkYellow),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildColorfulText('100', R.color.target),
                        ),

                        //
                        Expanded(
                          flex: smallFlex,
                          child: _buildColorfulText('50', R.color.darkRed),
                        ),
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

  Widget _buildBigSmallCardText(String text, Color color) {
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

  Widget _buildSmallCardText(String text) {
    return Center(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline5,
      ),
    );
  }

  Widget _buildColorfulText(String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Spacer(
          flex: 10,
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
        Spacer(flex: 10),
      ],
    );
  }
}
