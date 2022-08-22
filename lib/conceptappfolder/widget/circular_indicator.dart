import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

class Circular_Indicator extends StatefulWidget {
  const Circular_Indicator({
    Key? key,
  }) : super(key: key);

  @override
  State<Circular_Indicator> createState() => _Circular_IndicatorState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _Circular_IndicatorState extends State<Circular_Indicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(
      reverse: true, /*max: 3*/
    );
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircularProgressIndicator(
          value: controller.value,
          strokeWidth: 3,
          valueColor: controller.drive(ColorTween(
            begin: Color(0xFFB32245),
            end: Color(0xFF412D3A),
          )),
          // semanticsLabel: 'Linear progress indicator',
        ),
      ],
    );
  }
}
