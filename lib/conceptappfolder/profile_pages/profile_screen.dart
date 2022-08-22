import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concept/profile_pages/post_list_view.dart';
import 'package:concept/profile_pages/saved_collection.dart';
import 'package:concept/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/utils.dart';
import '../widget/video_player_profile.dart';

class Profile_Screen extends StatefulWidget {
  final String? uid;
  const Profile_Screen({Key? key,  this.uid}) : super(key: key);



  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> with  TickerProviderStateMixin {
   // TabController? tabController;



  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  String? uid;



  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    getData();




      // ..addListener(() {
      //   // setState(() {
      //   //   switch (tabController.index) {
      //   //     case 0:
      //   //       fabIcon = Icons.post_add_sharp;
      //   //       break;
      //   //     case 1:
      //   //       fabIcon = Icons.save_alt;
      //   //       break;
      //   //   }
      //   // });
      // });

  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // get post LENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {  TabController _tabController = TabController(length: 2, vsync: this);

  return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        height:170,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/profilebg.png"),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage(),));
                                  },
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Color(0xFFFFFFFF),
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("c/${userData['username']}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                  ),
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.ios_share, color: Color(0xFFFFFFFF),size: 25,),
                                  ),

                                  TextButton(onPressed: (){},
                                    child: Text("Edit", style: GoogleFonts.roboto(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      offset: Offset(0.0, 8.0),
                                      color: Color(0xFF000000).withOpacity(0.5),
                                    )
                                  ],
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(userData['photoUrl']),
                                    // fit: BoxFit.fill
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    children: [
                      Text("Name"),
                      Text("Bio",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.4),
                        ),),
                    ],
                  ),
                ),
        Container(
          child: TabBar(
              labelColor: Colors.black,
              labelPadding: EdgeInsets.all(5),
              labelStyle: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold),
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                  text: "Posts",
                ),
                Tab(
                  text: "Saved",
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height / 1.3,
          child: TabBarView(
              controller: _tabController,
              children: [
              ListView(children: [PostsListView()]),
                SavedCollection(),
              ]),
        ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}



// import 'package:concept/profile_pages/post_list_view.dart';
// import 'package:concept/profile_pages/saved_collection.dart';
// import 'package:concept/screens/uploading_screens/gallery.dart';
// import 'package:flutter/material.dart';
//
//
//
// class HomeScreenEx extends StatefulWidget {
//   const HomeScreenEx({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenExState createState() => _HomeScreenExState();
// }
//
// class _HomeScreenExState extends State<HomeScreenEx> with SingleTickerProviderStateMixin {
//
//   late TabController tabController;
//   var fabIcon = Icons.message;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     tabController = TabController(vsync: this, length:2)
//       ..addListener(() {
//         setState(() {
//           switch (tabController.index) {
//             case 0:
//               fabIcon = Icons.camera_alt_outlined;
//               break;
//             case 1:
//               fabIcon = Icons.chat;
//               break;
//             case 2:
//               fabIcon = Icons.camera_alt_outlined;
//               break;
//             case 2:
//               fabIcon = Icons.message;
//               break;
//           }
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//       body:,
//
//     );
//   }
// }
