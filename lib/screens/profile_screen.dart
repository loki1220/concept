import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../widget/follow_button.dart';
import '../widget/gradient_icon.dart';
import '../widget/utils.dart';
import 'login_page.dart';

class Profile_Screen extends StatefulWidget {
  final String? uid;
  const Profile_Screen({Key? key, this.uid}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _auth = FirebaseAuth.instance;

  void googleLogout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    if (User != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => LoginPage()));
    }
  }
  // bool isLoading = false;

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
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // get post lENGTH
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
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : SafeArea(
          child: Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(
      //     userData['username'],
      //   ),
      //   centerTitle: false,
      // ),
      body: Column(
          children: [
          Container(
            height: 230,
            child: Stack(
              children: [
                Container(
                  height:180,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                   // color: Colors.black,
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
                            onPressed: (){},
                            icon: Icon(Icons.settings, color: Color(0xFFFFFFFF),),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("c/${userData['username']}",
                              textAlign: TextAlign.center,
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
                              icon: Icon(Icons.ios_share, color: Color(0xFFFFFFFF),),
                            ),

                            TextButton(onPressed: (){},
                            child: Text("Edit", style: GoogleFonts.roboto(
                              color: Color(0xFFFFFFFF)
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
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(userData['photoUrl']),
                              fit: BoxFit.fill
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
          Column(
            children: [
              Text("Nickname"),
              Text("Math worm\n Probability enthu",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.4),
              ),),
            ],
          ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("10 d"),
                    Text("25 - Feb - 2022"),
                    Text("0 Followers"),
                  ],
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text("Post"),
                ),
              ],
            ),
            Divider(),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', isEqualTo: uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                    (snapshot.data! as dynamic).docs[index];

                    return Container(
                      child: Image(
                        image: NetworkImage(snap['postUrl']),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            )
          ],
      ),


     /* ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'],
                        ),
                        radius: 40,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStatColumn(postLen, "posts"),
                                buildStatColumn(followers, "followers"),
                                buildStatColumn(following, "following"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                FirebaseAuth.instance.currentUser!.uid ==
                                    uid
                                    ? FollowButton(
                                  text: 'Sign Out',
                                  backgroundColor:
                                  Colors.black,
                                  textColor: Colors.white,
                                  borderColor: Colors.grey,
                                  function: () async {
                                    googleLogout();
                                    await AuthMethods().signOut();
                                    Navigator.of(context)
                                        .pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPage(),
                                      ),
                                    );
                                  },
                                )
                                    : isFollowing
                                    ? FollowButton(
                                  text: 'Unfollow',
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  borderColor: Colors.grey,
                                  function: () async {
                                    await FireStoreMethods()
                                        .followUser(
                                      FirebaseAuth.instance
                                          .currentUser!.uid,
                                      userData['uid'],
                                    );

                                    setState(() {
                                      isFollowing = false;
                                      followers--;
                                    });
                                  },
                                )
                                    : FollowButton(
                                  text: 'Follow',
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  borderColor: Colors.blue,
                                  function: () async {
                                    await FireStoreMethods()
                                        .followUser(
                                      FirebaseAuth.instance
                                          .currentUser!.uid,
                                      userData['uid'],
                                    );

                                    setState(() {
                                      isFollowing = true;
                                      followers++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      userData['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      top: 1,
                    ),
                    child: Text(
                      'loki' userData['bio'],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', isEqualTo: uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                    (snapshot.data! as dynamic).docs[index];

                    return Container(
                      child: Image(
                        image: NetworkImage(snap['postUrl']),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            )
          ],
      ),*/
    ),
        );
      // appBar: AppBar(
      //   title: TextButton(
      //     child: Text(
      //       "Sign Out",
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //     onPressed: () async {
      //       await AuthMethods().signOut();
      //       googleLogout();
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => const LoginPage(),
      //         ),
      //       );
      //     },
      //   ),
      // ),
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
