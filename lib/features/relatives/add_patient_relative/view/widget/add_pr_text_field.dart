part of '../add_relative_screen.dart';

class _AddPRTextField extends StatelessWidget {
  const _AddPRTextField({
    Key? key,
    required this.prefixSvgPath,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.counterText,
    this.focusNode,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.maxLenght,
    this.readOnly,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  final Function(String)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final String? counterText;
  final FocusNode? focusNode;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLenght;
  final String prefixSvgPath;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RbioTextFormField(
        hintText: hintText,
        maxLength: maxLenght,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        counterText: counterText,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        prefixIcon: SvgPicture.asset(
          prefixSvgPath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
