// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Userdetails {
//   final String uid;
//   final String photoUrl;
//
//   const Userdetails({
//     required this.uid,
//     required this.photoUrl,
//   });
//
//   static Userdetails fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//
//     return Userdetails(
//       uid: snapshot["uid"],
//       photoUrl: snapshot["photoUrl"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "uid": uid,
//         "photoUrl": photoUrl,
//       };
// }
