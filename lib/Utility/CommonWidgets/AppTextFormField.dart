import 'package:flutter/material.dart';

import '../color_constants.dart';
class CustomTextFormField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;



  const CustomTextFormField({super.key, required this.hint,  this.isPassword = false, this.suffixIcon, required this.textEditingController, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(),
      validator: validator,
      controller: textEditingController,
      obscureText: isPassword,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          borderSide: BorderSide(color: textboxColor, width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          borderSide: BorderSide(color: textboxColor, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
