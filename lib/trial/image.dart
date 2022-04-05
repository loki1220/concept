import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery.dart';

class Image_screen extends StatefulWidget {
  const Image_screen({Key? key}) : super(key: key);

  @override
  State<Image_screen> createState() => _Image_screenState();
}

class _Image_screenState extends State<Image_screen> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      // make the function async
      onPressed: () async {
        // ### Add the next 2 lines ###
        final permitted = await PhotoManager.requestPermissionExtend();
        if (permitted == true) return;
        // ######
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => Gallery()),
        );
      },
      child: Text('Open Gallery'),
    );
  }
}
