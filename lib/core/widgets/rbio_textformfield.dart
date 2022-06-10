import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

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
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? enabled;
  final Widget? suffixIcon;
  final Color? backColor;
  final Color? textColor;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool isForSms;
  final InputDecoration? decoration;
  final String? counterText;
  final bool? readOnly;
  final void Function()? onTap;
  final bool? isDense;

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
    this.minLines,
    this.maxLines = 1,
    this.suffixIcon,
    this.backColor,
    this.textColor,
    this.autovalidateMode,
    this.isForSms = false,
    this.decoration,
    this.counterText,
    this.readOnly,
    this.onTap,
    this.isDense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isForSms
        ? TextFieldPinAutoFill(
            style: Utils.instance.inputTextStyle(textColor),
            focusNode: focusNode,
            obscureText: obscureText ?? false,
            currentCode: controller?.text ?? "",
            decoration: defaultDecoration(
              context,
              hintText: hintText,
              labelText: labelText,
              contentPadding: contentPadding,
              border: border,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              backColor: backColor,
            ).copyWith(
              counterText: "",
            ),
            inputFormatters: inputFormatters,
            onCodeSubmitted: onFieldSubmitted,
            onCodeChanged: onChanged,
          )
        : TextFormField(
            
            maxLength: maxLength,
            maxLines: maxLines,
            minLines: minLines,
            initialValue: initialValue,
            style: Utils.instance.inputTextStyle(textColor),
            focusNode: focusNode,
            controller: controller,
            autocorrect: autocorrect ?? true,
            enabled: enabled,
            autovalidateMode: autovalidateMode,
            validator: validator,
            enableSuggestions: enableSuggestions ?? true,
            onTap: onTap,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            readOnly: readOnly ?? false,
            decoration: decoration?.copyWith(
                  isDense: isDense,
                  contentPadding: contentPadding,
                  errorStyle: context.xBodyText1Error,
                  errorBorder: _redErrorBorder(),
                  focusedBorder: _focusedBorder(),
                  focusedErrorBorder: _focusedRedErrorBorder(),
                  counterText: counterText,
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                ) ??
                defaultDecoration(
                  context,
                  hintText: hintText,
                  labelText: labelText,
                  contentPadding: contentPadding,
                  border: border,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  backColor: backColor,
                ).copyWith(
                  isDense: isDense,
                  errorStyle: context.xBodyText1Error,
                  errorBorder: _redErrorBorder(),
                  focusedBorder: _focusedBorder(),
                  focusedErrorBorder: _focusedRedErrorBorder(),
                  counterText: counterText,
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                ),
            cursorColor: getIt<IAppConfig>().theme.mainColor,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            onFieldSubmitted: onFieldSubmitted,
          );
  }

  static OutlineInputBorder _focusedRedErrorBorder() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: getIt<IAppConfig>().theme.darkRed, width: 2.0),
        borderRadius: R.sizes.borderRadiusCircular);
  }

  static OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
        borderRadius: R.sizes.borderRadiusCircular);
  }

  static OutlineInputBorder _redErrorBorder() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: getIt<IAppConfig>().theme.darkRed, width: 1.0),
        borderRadius: R.sizes.borderRadiusCircular);
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
        borderRadius: R.sizes.borderRadiusCircular,
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: getIt<IAppConfig>().theme.darkWhite,
        ),
      );

  static InputBorder activeBorder() => OutlineInputBorder(
        borderRadius: R.sizes.borderRadiusCircular,
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: getIt<IAppConfig>().theme.mainColor,
        ),
      );
}
