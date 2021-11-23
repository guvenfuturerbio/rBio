import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/profile/health_information/viewmodel/health_information_vm.dart';

Widget _dropDownWidget(BuildContext context, HealthInformationVm vm) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: getIt<ITheme>().mainColor),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<String>(
        value: vm.selection.smoker
            ? LocaleProvider.current.yes
            : LocaleProvider.current.no,
        dropdownColor: getIt<ITheme>().mainColor,
        elevation: 0,
        isDense: true,
        icon: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: SvgPicture.asset(
            R.image.arrow_down_icon,
            color: getIt<ITheme>().textColor,
            width: 15,
          ),
        ),
        style: TextStyle(color: getIt<ITheme>().mainColor),
        underline: SizedBox(),
        onChanged: (String newValue) {
          vm.smokerToggle(newValue);
        },
        items: <String>[LocaleProvider.current.yes, LocaleProvider.current.no]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style:
                  context.xHeadline3.copyWith(color: getIt<ITheme>().textColor),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget healthInfoItem(BuildContext context, HealthInformationVm vm,
    {String one_one,
    String one_two,
    String two_one,
    String two_two,
    bool smokeCheck = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                one_one,
                style: context.xHeadline1
                    .copyWith(color: getIt<ITheme>().mainColor),
              ),
              smokeCheck
                  ? _dropDownWidget(context, vm)
                  : Text(one_two, style: context.xHeadline2)
            ],
          ),
        ),
        Spacer(),
        Expanded(
          flex: 3,
          child: two_one == null || two_two == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(two_one,
                        style: context.xHeadline1
                            .copyWith(color: getIt<ITheme>().mainColor)),
                    Text(
                      two_two,
                      style: context.xHeadline2,
                    )
                  ],
                ),
        )
      ],
    ),
  );
}
