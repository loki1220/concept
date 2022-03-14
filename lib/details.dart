import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:concept/started_page.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:concept/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Details extends StatefulWidget {
  const Details(
      {Key? key,
      required this.assetImage,
      this.assetImageHeight,
      this.assetImageWidth,
      this.divisions})
      : super(key: key);

  final String assetImage;
  final int? assetImageHeight;
  final int? assetImageWidth;
  final int? divisions;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();

  Uint8List? _file;

  final picker = ImagePicker();

  // editing Controller
  final userNameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/dp1.png"),
                        radius: 40,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/dp2.png"),
                        radius: 40,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/dp3.png"),
                            radius: 40,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/dp4.png"),
                            radius: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xFFE063FF).withOpacity(0.8),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.camera);
                        },
                        child: Text(
                          "Take Photo",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF575757)),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xFF28B6ED).withOpacity(0.8),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                        },
                        child: Text(
                          "Choose from library",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF575757)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  //variable for slider
  double intValue = 0;
  ui.Image? customImage;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: widget.assetImageHeight,
        targetWidth: widget.assetImageWidth);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  @override
  void initState() {
    load(widget.assetImage).then((image) {
      setState(() {
        customImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //nextbutton
    final nextButton = Container(
      child: Material(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 6 * MediaQuery.of(context).size.width / 28,
          height: 45,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF28B6ED),
                Color(0xFFE063FF),
              ],
            ),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Started_Page(),
                ),
              );
            },
            child: Container(
              child: /*_isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
                  :*/
                  Text(
                "Next",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/detailsbg.png",
              fit: BoxFit.fill,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: kToolbarHeight + 15,
                    ),
                    Text(
                      "Profile",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF525252)),
                    ),
                    Container(
                      width: 130,
                      height: 130,
                      child: Center(
                        child: Container(
                          child: IconButton(
                            onPressed: () {
                              showCustomDialog(context);
                            },
                            icon: GradientIcon(
                              Icons.camera_alt_outlined,
                              40.0,
                              LinearGradient(
                                colors: <Color>[
                                  Color(0xFFFA0AFF),
                                  Color(0xFF28B6ED),
                                ],
                                begin: Alignment.center,
                              ),
                            ),
                          ),
                          width: 125.0,
                          height: 125.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            // image: DecorationImage(
                            //   fit: BoxFit.fill,
                            //   image: NetworkImage(
                            //       "https://images.unsplash.com/photo-1594899756066-46964fff3add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=170&q=80"),
                            // ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF28B6ED), Color(0xFFE063FF)],
                        ),
                      ),
                    ),
                    MyTextField(
                      obscureText: false,
                      isCenter: true,
                      controller: userNameEditingController,
                      fieldname: "User Name",
                    ),
                    MyTextField(
                      obscureText: true,
                      isCenter: true,
                      controller: passwordEditingController,
                      fieldname: "Password",
                      validator: (value) {
                        RegExp regex = new RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter (Min. 8 letter, 1 Caps letter, 1 special letter, 1 Num)");
                        }
                      },
                    ),
                    MyTextField(
                      obscureText: true,
                      isCenter: true,
                      controller: confirmPasswordEditingController,
                      fieldname: "Confirm Password",
                      validator: (value) {
                        if (confirmPasswordEditingController.text !=
                            passwordEditingController.text) {
                          return "Password don't match";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            inactiveTrackColor: Colors.white,
                            trackShape: GradientSliderTrackShape(
                                linearGradient: LinearGradient(colors: [
                              Color(0xFFE063FF),
                              Color(0xFF28B6ED)
                            ])),
                            trackHeight: 12.0,
                            // overlayColor: Colors.purple.withAlpha(36),
                            thumbShape: customImage != null
                                ? SliderThumbImage(customImage!)
                                : const RoundSliderThumbShape()),
                        child: Slider(
                          min: 0,
                          max: 100,
                          divisions: widget.divisions,
                          onChanged: (double value) {
                            setState(() {
                              intValue = value;
                            });
                          },
                          value: intValue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          nextButton,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  LinearGradient? linearGradient;

  GradientSliderTrackShape({this.linearGradient}) {
    linearGradient ??
        const LinearGradient(colors: [
          Colors.black,
          Colors.amber,
        ]);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    assert(isEnabled != null);
    assert(isDiscrete != null);

    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..shader = linearGradient!.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect leftTrackSegment = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);
    if (!leftTrackSegment.isEmpty)
      context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom);
    if (!rightTrackSegment.isEmpty)
      context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    var canvas = context.canvas;
    final picWidth = image.width;
    final picHeight = image.height;

    Offset picOffset = Offset(
      (center.dx - (picWidth / 2)),
      (center.dy - (picHeight / 2)),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, picOffset, paint);
  }
}
