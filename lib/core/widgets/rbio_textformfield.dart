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
  final String labelText;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onFieldSubmitted;
  final bool obscureText;
  final bool enableSuggestions;
  final void Function(String) onChanged;
  final EdgeInsetsGeometry contentPadding;
  final InputBorder border;
  final String initialValue;
  final int maxLines;

  const RbioTextFormField(
      {Key key,
      this.initialValue,
      this.focusNode,
      this.controller,
      this.keyboardType,
      this.hintText,
      this.labelText,
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
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
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
            labelText: labelText,
            contentPadding: context.xTextScaleType == TextScaleType.Small
                ? contentPadding
                : EdgeInsets.only(left: 8),
            inputBorder: border ?? defaultBorder(),
          )
          .copyWith(
            filled: true,
            fillColor: getIt<ITheme>().cardBackgroundColor,
          ),
      cursorColor: getIt<ITheme>().mainColor,
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
