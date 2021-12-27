import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../model/patient_list_model.dart';
import '../viewmodel/patient_list_vm.dart';

// ignore: must_be_immutable
class DoctorPatientListScreen extends StatelessWidget {
  DoctorPatientListScreen({Key key}) : super(key: key);

  // #region AtomParams
  PatientType type;
  // #endregion

  final bigFlex = 40;
  final smallFlex = 25;

  final FocusNode _searchfocusNode = FocusNode();

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
  Widget _buildPatients(BuildContext context, DoctorPatientListVm vm) =>
      RbioKeyboardActions(
        focusList: [
          _searchfocusNode,
        ],
        child: Column(
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
        ),
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
                focusNode: _searchfocusNode,
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
                      tiles: vm.getPopupWidgets(),
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
    final list = vm.getList;

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: vm.getitemCount,
      itemBuilder: (BuildContext context, int index) {
        return R.sizes.textScaleBuilder(
          context,
          smallWidget: _buildCard(context, vm, list[index], isLarge: false),
          largeWidget: _buildCard(context, vm, list[index], isLarge: true),
        );
      },
    );
  }
  // #endregion

  // #region _buildCard
  Widget _buildCard(
    BuildContext context,
    DoctorPatientListVm vm,
    PatientListItemModel model, {
    @required bool isLarge,
  }) {
    if (isLarge) {
      return _buildLargeCard(
        context,
        onTap: () => vm.itemOnTap(model.data),
        name: model.patientName,
        dates: model.dates
            .map(
              (e) => _buildSmallExpanded(
                child: _buildSmallCardText(context, e),
              ),
            )
            .toList(),
        times: model.times
            .map(
              (e) => _buildSmallExpanded(
                child: _buildSmallCardText(context, e),
              ),
            )
            .toList(),
        values: model.values
            .map(
              (e) => _buildSmallExpanded(
                child: _buildColorfulText(
                  true,
                  context,
                  e,
                  vm.getBackColor(e, model.data),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return _buildSmallCard(
        context,
        onTap: () => vm.itemOnTap(model.data),
        name: model.patientName,
        dates: model.dates
            .map(
              (e) => _buildSmallExpanded(
                child: _buildSmallCardText(context, e),
              ),
            )
            .toList(),
        times: model.times
            .map(
              (e) => _buildSmallExpanded(
                child: _buildSmallCardText(context, e),
              ),
            )
            .toList(),
        values: model.values
            .map(
              (e) => _buildSmallExpanded(
                child: _buildColorfulText(
                  true,
                  context,
                  e,
                  vm.getBackColor(e, model.data),
                ),
              ),
            )
            .toList(),
      );
    }
  }
  // #endregion

  // #region _buildSmallExpanded
  Widget _buildSmallExpanded({@required Widget child}) =>
      Expanded(flex: smallFlex, child: child);
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
                          LocaleProvider.current.patient_name_2,
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
                            LocaleProvider.current.patient_name_2,
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
