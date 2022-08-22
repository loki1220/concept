import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  var _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}



// class GradientIcon extends StatelessWidget {
//   GradientIcon(
//     this.icon,
//     this.size,
//     this.gradient,
//   );
//
//   final IconData icon;
//   final double size;
//   final Gradient gradient;
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       child: SizedBox(
//         width: size * 1.2,
//         height: size * 1.2,
//         child: Icon(
//           icon,
//           size: size,
//           color: Colors.white,
//         ),
//       ),
//       shaderCallback: (Rect bounds) {
//         final Rect rect = Rect.fromLTRB(0, 0, size, size);
//         return gradient.createShader(rect);
//       },
//     );
//   }
// }
