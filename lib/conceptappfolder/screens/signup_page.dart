import 'dart:typed_data';
import 'dart:io';
import 'package:concept/resources/auth_methods.dart';
import 'package:concept/widget/circular_indicator.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:concept/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/gradient_icon.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool _secureText = true;
  bool _securityText = true;

  // editing Controller
  final usernameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  bool _isLoading = false;

  Uint8List? _image;

  final picker = ImagePicker();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        username: usernameEditingController.text,
        email: emailEditingController.text,
        password: passwordEditingController.text,
        file: _image!);

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

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
                          selectImageCamera();
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
                          selectImageGallery();
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

  selectImageGallery() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.teal,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        Uint8List imageRaw = await croppedFile.readAsBytes();
        setState(() {
          _image = imageRaw;
          print('this is file path = $_image');
        });
      }
    }

    // Uint8List im = await pickImage(ImageSource.gallery);
    // // set state because we need to display the image we selected on the circle avatar
    // setState(() {
    //   _image = im;
    // });
  }

  selectImageCamera() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.teal,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        Uint8List imageRaw = await croppedFile.readAsBytes();
        setState(() {
          _image = imageRaw;
        });
      }
    }
    // set state because we need to display the image we selected on the circle avatar
    // setState(() {
    //   _image = im;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    //registerbutton
    final registerButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 12,
        height: 45,
        //height: 2 * MediaQuery.of(context).size.height / 38,
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
              // if(fullnameEditingController.text.isEmpty || fullnameEditingController.text.length<3){
              //   return;
              // }else if(emailEditingController.text.isEmpty ){
              //   return;
              // }else if(passwordEditingController.text.isEmpty || passwordEditingController.)
              if (_formKey.currentState!.validate()) {
                // final snackBar = SnackBar(content: Text('Submitting form'));
                // _scaffoldKey.currentState!.showSnackBar(snackBar);
                signUpUser();
              }

              FocusScope.of(context).unfocus();
            },
            child: Container(
              child: _isLoading
                  ? const Center(
                      child: Circular_Indicator(
                          // backgroundColor: Color(0xFFFFFFFF),
                          // strokeWidth: 3.0,
                          // color: Colors.black54,
                          ),
                    )
                  : Text(
                      "Sign up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF)),
                    ),
            )),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFE9A7F4).withOpacity(0.9),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF000000),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Register",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000)),
          ),
        ),
        //resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgregister.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Profile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF525252)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                _image != null
                                    ? Container(
                                        width: 130,
                                        height: 130,
                                        child: Center(
                                          child: Container(
                                            child: IconButton(
                                              onPressed: () {
                                                showCustomDialog(context);
                                              },
                                              icon: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 80,
                                                    vertical: 80),
                                                child: GradientIcon(
                                                  Icons.camera_alt_outlined,
                                                  40.0,
                                                  const LinearGradient(
                                                    colors: <Color>[
                                                      Color(0xFFFA0AFF),
                                                      Color(0xFF28B6ED),
                                                    ],
                                                    begin: Alignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            width: 125.0,
                                            height: 125.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                // fit: BoxFit.fill,
                                                image: MemoryImage(_image!),
                                              ),
                                            ),
                                          ),
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF28B6ED),
                                              Color(0xFFE063FF)
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 130,
                                        height: 130,
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  showCustomDialog(context);
                                                },
                                                icon: GradientIcon(
                                                  Icons.camera_alt_outlined,
                                                  40.0,
                                                  const LinearGradient(
                                                    colors: <Color>[
                                                      Color(0xFFFA0AFF),
                                                      Color(0xFF28B6ED),
                                                    ],
                                                    begin: Alignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            width: 125.0,
                                            height: 125.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                // fit: BoxFit.fill,
                                                image: AssetImage("assets/defaultProfile.jpg")/*MemoryImage(_image!)*/,
                                              ),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF28B6ED),
                                              Color(0xFFE063FF)
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        MyTextField(
                          autofocus: false,
                          obscureText: false,
                          isCenter: true,
                          controller: usernameEditingController,
                          fieldname: "Username",
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          helperText: "",
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("Name cannot be Empty");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid name(Min. 3 Character)");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            usernameEditingController.text = value!;
                          },
                          maxLength: 30,
                        ),
                        MyTextField(
                          autofocus: false,
                          obscureText: false,
                          isCenter: true,
                          controller: emailEditingController,
                          fieldname: "Enter email address",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          helperText: "",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            usernameEditingController.text = value!;
                          },
                        ),
                        MyTextField(
                          autofocus: false,
                          obscureText: _secureText,
                          // key: _formKey,
                          isCenter: true,
                          controller: passwordEditingController,
                          fieldname: "password",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            RegExp regex = new RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$(){}=+^%?/.,:;_&*~-]).{8,}$');
                            if (value!.isEmpty) {
                              return ("Password is must for signup");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter (Min. 8 letter, 1 Caps letter, 1 special letter, 1 Num)");
                            }
                          },
                          onSaved: (value) {
                            passwordEditingController.text = value!;
                          },
                          suffixbutton: IconButton(
                            icon: Icon(
                              _secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
                        ),
                        MyTextField(
                          autofocus: false,
                          obscureText: _securityText,
                          isCenter: true,
                          controller: confirmPasswordEditingController,
                          fieldname: "Confirm Password",
                          textInputAction: TextInputAction.done,
                          helperText: "",
                          validator: (value) {
                            if (confirmPasswordEditingController.text !=
                                passwordEditingController.text) {
                              return "Password don't match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            usernameEditingController.text = value!;
                          },
                          suffixbutton: IconButton(
                            icon: Icon(
                              _securityText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _securityText = !_securityText;
                              });
                            },
                          ),
                        ),
                        registerButton,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
