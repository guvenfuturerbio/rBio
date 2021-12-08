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
  final EdgeInsetsGeometry contentPadding;
  final InputBorder border;
  final String initialValue;

  const RbioTextFormField({
    Key key,
    this.initialValue,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onChanged,
    this.contentPadding =
        const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    this.enableSuggestions = true,
    this.obscureText = false,
    this.autocorrect = true,
    this.textInputAction = TextInputAction.next,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
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
            inputBorder: border ?? defaultBorder(),
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

  static InputBorder noneBorder() => InputBorder.none;

  static InputBorder defaultBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: R.color.dark_white,
        ),
      );

  static InputBorder activeBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: getIt<ITheme>().mainColor,
        ),
      );
}
