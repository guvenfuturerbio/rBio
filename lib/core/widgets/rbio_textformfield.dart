import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class RbioTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool autocorrect;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onFieldSubmitted;
  final bool obscureText;
  final bool enableSuggestions;
  final void Function(String) onChanged;
  final bool showBorder;
  final EdgeInsetsGeometry contentPadding;

  const RbioTextFormField({
    Key key,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onChanged,
    this.contentPadding =
        const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    this.showBorder = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.autocorrect = true,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Utils.instance.inputTextStyle(),
      focusNode: focusNode,
      controller: controller,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: Utils.instance
          .inputDecorationForLogin(
            hintText: hintText,
            contentPadding: contentPadding,
            showBorder: showBorder,
          )
          .copyWith(
            filled: true,
            fillColor: getIt<ITheme>().cardBackgroundColor,
          ),
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
