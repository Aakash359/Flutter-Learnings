import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/const.dart';

class CommonInput extends StatelessWidget {
  final String? hintText;
  final Function? validator;
  final bool obscureText;
  final bool autoFocus;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? ctrl;
  const CommonInput(
      {super.key,
      this.hintText,
      required this.validator,
      required this.obscureText,
      required this.autoFocus,
      required this.keyboardType,
      required this.ctrl,
      required this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      obscureText: obscureText,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      controller: ctrl,
      style: const TextStyle(
        color: kInputColor,
      ),
      textAlign: TextAlign.start,
      validator: (input) => validator!(input),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5, color: Color.fromARGB(255, 204, 216, 215)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 204, 216, 215)), //<-- SEE HERE
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 204, 216, 215)), //<-- SEE HERE
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 204, 216, 215)), //<-- SEE HERE
        ),
        hintText: hintText,
        filled: true,
        fillColor: kWhiteColor,
      ),
    );
  }
}
