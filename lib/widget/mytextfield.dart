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

  final bool isCenter;

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
        Container(
          height: 45,
          child: TextFormField(
            cursorColor: Colors.black,
            //textDirection: TextDirection.ltr,
            controller: controller,
            keyboardType: keyboardType,
            /*TextInputType.emailAddress,*/
            validator: validator,
            maxLength: maxLength,
            /*(value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
              return null;
            },*/
            onSaved: onSaved,
            textAlign: isCenter ? TextAlign.center : TextAlign.start,

            /*(value) {
              controller?.text = value!;
            },*/
            //textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              counterText: "",
              suffixIcon: suffixbutton,
              prefixText: prefixText,
              prefix: prefix,
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: isCenter ? 0 : 15),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
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
        ),
      ],
    );
  }
}
