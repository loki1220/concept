import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
    this.width,
    this.height,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: width,
        height: height,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
