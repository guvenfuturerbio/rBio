import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/symptoms_home_vm.dart';

class SymptomsHomeScreen extends StatefulWidget {
  const SymptomsHomeScreen({Key key}) : super(key: key);

  @override
  _SymptomsHomeScreenState createState() => _SymptomsHomeScreenState();
}

class _SymptomsHomeScreenState extends State<SymptomsHomeScreen> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SymptomsHomeVm>(
      create: (context) => SymptomsHomeVm(context: context),
      child: RbioScaffold(
        resizeToAvoidBottomInset: false,
        appbar: _buildAppBar(),
        body: Consumer<SymptomsHomeVm>(
          builder: (context, value, child) {
            return _buildBody(value);
          },
        ),
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).my_symptoms,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody(SymptomsHomeVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildSuccess(context, value);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
  // #endregion

  // #region _buildSuccess
  Widget _buildSuccess(BuildContext context, SymptomsHomeVm value) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildExplanationText(LocaleProvider.of(context).preselection),

            //
            _buildSelectionTile(
              context,
              value,
              true,
              LocaleProvider.of(context).gender_male,
              R.image.man_icon,
              0,
            ),

            //
            _buildSelectionTile(
              context,
              value,
              true,
              LocaleProvider.of(context).gender_female,
              R.image.women_icon,
              1,
            ),

            //
            _buildSelectionTile(
              context,
              value,
              false,
              LocaleProvider.of(context).boy,
              R.image.boy_child_icon,
              2,
            ),

            //
            _buildSelectionTile(
              context,
              value,
              false,
              LocaleProvider.of(context).girl,
              R.image.girl_child_icon,
              3,
            ),

            //
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //
                  _buildExplanationText(
                      LocaleProvider.of(context).select_birth_year),

                  //
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      child: Card(
                        elevation: 6,
                        child: Container(
                          child: Center(
                            child: Text(
                              value.yearOfBirth,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //
                  Divider(),

                  //
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    alignment: Alignment.center,
                    child: NumberPicker(
                      value: int.parse(value.yearOfBirth),
                      minValue: 1900,
                      maxValue: DateTime.now().year.toInt(),
                      step: 1,
                      itemHeight: 25,
                      axis: Axis.vertical,
                      onChanged: (newValue) {
                        value.yearOfBirthHandle(
                            newValue.toString(), value.genderIdHolder);
                      },
                      textStyle: context.xHeadline3,
                      selectedTextStyle: context.xHeadline1.copyWith(
                        color: getIt<ITheme>().mainColor,
                      ),
                    ),
                  ),

                  //
                  Divider(),

                  //
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  )
                ],
              ),
            ),
          ],
        ),

        //
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: RbioElevatedButton(
              onTap: () async {
                Atom.to(
                  PagePaths.SYMPTOM_BODY_LOCATIONS,
                  queryParameters: {
                    'selectedGenderId': value.genderIdHolder.toString(),
                    'yearOfBirth': value.yearOfBirth,
                    'isFromVoice': false.toString(),
                  },
                );
              },
              title: LocaleProvider.of(context).continue_lbl,
            ),
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildSelectionTile
  Widget _buildSelectionTile(
    BuildContext context,
    SymptomsHomeVm value,
    bool isOld,
    String title,
    String iconPath,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        if (isOld) {
          DateTime.now().year - int.parse(value.yearOfBirth) < 18
              ? null
              : value.fetchGenderSelection(index);
        } else {
          DateTime.now().year - int.parse(value.yearOfBirth) < 18
              ? value.fetchGenderSelection(index)
              : null;
        }
      },
      child: Opacity(
        opacity: isOld
            ? (DateTime.now().year - int.parse(value.yearOfBirth) < 18
                ? 0.1
                : 1)
            : (DateTime.now().year - int.parse(value.yearOfBirth) < 18
                ? 1
                : 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Card(
            color: value.genderIdHolder == index
                ? getIt<ITheme>().mainColor
                : getIt<ITheme>().cardBackgroundColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                  child: SvgPicture.asset(
                    iconPath,
                    height: R.sizes.iconSize,
                    color: value.genderIdHolder == index ? R.color.white : null,
                  ),
                ),

                //
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.xHeadline4.copyWith(
                      color:
                          value.genderIdHolder == index ? R.color.white : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildExplanationText
  Center _buildExplanationText(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Text(
          title,
          style: context.xHeadline2.copyWith(
            color: getIt<ITheme>().textColorPassive,
          ),
        ),
      ),
    );
  }
  // #endregion
}
