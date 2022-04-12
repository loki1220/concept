// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PostsListView extends StatefulWidget {
//   const PostsListView({Key? key}) : super(key: key);
//
//   @override
//   State<PostsListView> createState() => _PostsListViewState();
// }
//
// class _PostsListViewState extends State<PostsListView> {
//
//
//   final _auth = FirebaseAuth.instance;
//
//   String? uid;
//
//   @override
//   void initState() {
//     super.initState();
//     uid = FirebaseAuth.instance.currentUser!.uid;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: uid)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         return GridView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemCount: (snapshot.data! as dynamic).docs.length,
//           gridDelegate:
//           const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 1.5,
//             childAspectRatio: 1,
//           ),
//           itemBuilder: (context, index) {
//             DocumentSnapshot snap =
//             (snapshot.data! as dynamic).docs[index];
//
//             return Container(
//               child: Image(
//                 image: NetworkImage(snap['postUrl']),
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
