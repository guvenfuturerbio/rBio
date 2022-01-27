import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class RbioCountryCodePicker extends StatelessWidget {
  final String initialSelection;
  final void Function(CountryCode countryCode) onChanged;
  final bool isActiveBorder;

  const RbioCountryCodePicker({
    Key key,
    this.initialSelection,
    this.onChanged,
    this.isActiveBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
        border: isActiveBorder
            ? Border.all(
                width: 0,
                style: BorderStyle.solid,
                color: getIt<ITheme>().mainColor,
              )
            : null,
      ),
      child: CountryCodePicker(
        onChanged: onChanged,
        initialSelection: initialSelection ?? 'TR',
        favorite: ['+90', 'TR'],

        //
        alignLeft: false,
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,

        // UI
        padding: EdgeInsets.zero,
        barrierColor: Colors.black87,
        backgroundColor: Colors.transparent,
        boxDecoration: BoxDecoration(
          color: getIt<ITheme>().cardBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        closeIcon: Icon(
          Icons.cancel,
          size: R.sizes.iconSize,
        ),
        searchDecoration: Utils.instance.inputDecorationForLogin(
          hintText: '',
          contentPadding: EdgeInsets.all(8),
          inputBorder: RbioTextFormField.activeBorder(),
        ),
        flagDecoration: BoxDecoration(),
        textStyle: context.xHeadline4,
        dialogTextStyle: context.xHeadline4,
        dialogSize: Size.fromHeight(Atom.height * 0.60),
        searchStyle: context.xHeadline4,
      ),
    );
  }
}
