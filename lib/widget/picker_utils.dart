// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Utils {
//   static Future<Object> pickMedia({
//     Future<File> Function(File file)? cropImage,
//   }) async {
//     final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
//
//     if (pickedFile == null) return Container(child: CircularProgressIndicator(),);
//
//     if (cropImage == null) {
//       return File(pickedFile.path);
//     } else {
//       final file = File(pickedFile.path);
//
//       return cropImage(file);
//     }
//   }
// }