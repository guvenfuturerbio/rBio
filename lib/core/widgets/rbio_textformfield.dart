import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class RbioTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? autocorrect;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final bool? obscureText;
  final bool? enableSuggestions;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final String? initialValue;
  final int? maxLines;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? enabled;
  final Widget? suffixIcon;
  final Color? backColor;
  final Color? textColor;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const RbioTextFormField({
    Key? key,
    this.maxLength,
    this.prefixIcon,
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
    this.validator,
    this.enabled,
    this.maxLines = 1,
    this.suffixIcon,
    this.backColor,
    this.textColor,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      initialValue: initialValue,
      style: Utils.instance.inputTextStyle(textColor),
      focusNode: focusNode,
      controller: controller,
      autocorrect: autocorrect ?? true,
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      validator: validator,
      enableSuggestions: enableSuggestions ?? true,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: defaultDecoration(
        context,
        hintText: hintText,
        labelText: labelText,
        contentPadding: contentPadding,
        border: border,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        backColor: backColor,
      ),
      cursorColor: getIt<IAppConfig>().theme.mainColor,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  static InputDecoration defaultDecoration(
    BuildContext context, {
    String? hintText,
    String? labelText,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? border,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? backColor,
  }) {
    return Utils.instance
        .inputDecorationForLogin(
          hintText: hintText,
          labelText: labelText,
          contentPadding: context.xTextScaleType == TextScaleType.small
              ? contentPadding
              : const EdgeInsets.only(left: 8),
          inputBorder: border ?? defaultBorder(),
          prefixIcon: prefixIcon,
        )
        .copyWith(
          filled: true,
          fillColor: backColor ?? getIt<IAppConfig>().theme.cardBackgroundColor,
          suffixIcon: suffixIcon,
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
          color: getIt<IAppConfig>().theme.mainColor,
        ),
      );
}
