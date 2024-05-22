import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../gen/fonts.gen.dart';

// class TextFieldWidget extends StatefulWidget {
//   final IconData? prefixIcon;
//   final String? labelText;
//   final TextEditingController? controller;
//   final bool? enabled;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final int? maxLength;
//   final void Function(String)? onChanged;
//   final bool? readOnly;
//   final void Function()? onTap;
//   final String? Function(String?)? validator;
//   final TextAlign? textAlign;
//   final String? initialValue;
//   final TextDirection? textDirection;
//   final BoxConstraints? prefixIconConstraints;
//   final int? maxLines;
//   const TextFieldWidget({
//     Key? key,
//     this.prefixIcon,
//     this.labelText,
//     this.controller,
//     this.enabled = true,
//     this.inputFormatters,
//     this.keyboardType,
//     this.maxLength,
//     this.onChanged,
//     this.validator,
//     this.textAlign,
//     this.initialValue,
//     this.textDirection,
//     this.prefixIconConstraints,
//     this.onTap,
//     this.readOnly = false,
//     this.maxLines = 1,
//   }) : super(key: key);
//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   bool isShowPassword = true;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.black12, width: 0.5),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         prefixIcon: Icon(
//           widget.prefixIcon,
//           color: Colors.black54,
//           size: 20,
//         ),
//         isDense: true,
//         contentPadding: EdgeInsets.zero,
//         errorStyle: const TextStyle(fontSize: 10, color: Colors.red),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black54,
//           ),
//         ),
//         labelStyle: const TextStyle(fontSize: 12, color: Colors.black54),
//         labelText: widget.labelText,
//         counterText: '',
//         prefixIconConstraints: widget.prefixIconConstraints,
//       ),
//       controller: widget.controller,
//       cursorColor: Colors.black,
//       cursorWidth: 0.5,
//       enabled: widget.enabled,
//       inputFormatters: widget.inputFormatters,
//       keyboardType: widget.keyboardType,
//       maxLength: widget.maxLength,
//       onChanged: widget.onChanged,
//       style: widget.enabled!
//           ? const TextStyle(fontSize: 14, color: Colors.black)
//           : const TextStyle(fontSize: 14, color: Colors.black54),
//       textAlign: widget.textAlign!,
//       textDirection: widget.textDirection,
//       validator: widget.validator,
//       initialValue: widget.initialValue,
//       readOnly: widget.readOnly!,
//       onTap: widget.onTap,
//       maxLines: widget.maxLines,
//     );
//   }
// }

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final void Function()? onTap;
  final bool readOnly;
  final String? labelText;
  final bool enabled;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextDirection? textDirection;
  final EdgeInsetsGeometry contentPadding;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLines;
  const TextFormFieldWidget({
    Key? key,
    this.controller,
    this.labelText,
    this.inputFormatters,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    this.maxLength,
    this.textAlign = TextAlign.right,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.textDirection,
    this.contentPadding = const EdgeInsets.fromLTRB(12.0, 20, 12.0, 12),
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: const Color(0XFF0a0b0c),
      // cursorHeight: 28,
      cursorWidth: 0.5,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      textDirection: textDirection,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0XFF2b2f33), width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
        errorStyle: const TextStyle(fontSize: 10, color: Color(0XFFDC3545)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0XFF2b2f33),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: const TextStyle(
            fontSize: 14, color: Colors.black38, fontFamily: FontFamily.iranSans),
        labelText: labelText,
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0XFFDC3545),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabled: enabled,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIconConstraints: prefixIconConstraints,
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: TextStyle(
          color: enabled ? const Color(0XFF2b2f33) : Colors.grey,
          fontFamily: FontFamily.iranSans,
          fontSize: 14),
      textAlign: textAlign,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      initialValue: initialValue,
      maxLines: maxLines,
    );
  }
}