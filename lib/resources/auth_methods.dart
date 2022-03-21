import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:concept/model/auth_users.dart' as model;
import 'package:fluttertoast/fluttertoast.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String fullname,
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (fullname.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .catchError((e) {
          Fluttertoast.showToast(
              msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
        });

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profil ePics', file, false);

        model.User _user = model.User(
          fullname: fullname,
          uid: cred.user!.uid,
          email: email,
          following: [],
          followers: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());
        Fluttertoast.showToast(msg: "Account created Successfully :) ");

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
