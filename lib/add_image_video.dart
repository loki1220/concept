import 'dart:convert';

import 'package:concept/widget/model/file.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:storage_path/storage_path.dart';

class Add_image extends StatefulWidget {
  const Add_image({Key? key, this.tittle}) : super(key: key);

  final String tittle;

  @override
  _Add_imageState createState() => _Add_imageState();
}

class _Add_imageState extends State<Add_image> {
  late List<FileModel> files;
  @override
  void initstate() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.clear,
                ),
                DropdownButtonHideUnderline(child: DropdownButton(items: , onChanged: ,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
