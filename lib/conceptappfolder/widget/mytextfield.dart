import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? txt;
  final String? fieldname;
  final Widget? suffixbutton;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? prefixText;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final String? helperText;

  final bool isCenter;
  final bool obscureText;
  final bool autofocus;

  final FormFieldSetter<String>? onSaved;

  const MyTextField({
    Key? key,
    this.controller,
    this.contentPadding,
    this.onSaved,
    this.txt,
    this.suffixbutton,
    this.validator,
    this.keyboardType,
    this.fieldname,
    required this.isCenter,
    this.maxLength,
    this.prefixText,
    this.prefix,
    required this.obscureText,
    this.textInputAction,
    this.helperText,
    required this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("${txt != null ? txt : ""}"),
            ],
          ),
        ),
        TextFormField(
          cursorColor: Colors.black,
          //textDirection: TextDirection.ltr,
          controller: controller,
          autofocus: autofocus,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          obscureText: obscureText,
          onSaved: onSaved,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffixbutton,
            prefixText: prefixText,
            prefix: prefix,
            filled: true,
            helperText: "",
            fillColor: Colors.white.withOpacity(0.8),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10, horizontal: isCenter ? 0 : 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            ),
            hintText: fieldname,
            hintStyle: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
