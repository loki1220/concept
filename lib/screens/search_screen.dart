import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concept/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/global_variables.dart';
import '../widget/video_player_profile.dart';

class Search_screen extends StatefulWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Form(
            child: CupertinoSearchTextField(
              placeholderStyle: TextStyle(

              ),
              controller: searchController,
              backgroundColor: Color(0xFF8C8C8C).withOpacity(0.3),
              onSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
        ),

        body: isShowUsers
            ? SingleChildScrollView(
              child: Container(
               height: MediaQuery.of(context).size.height / 1.4,
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where(
                          'username',
                          isGreaterThanOrEqualTo: searchController.text,
                        )
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){},/* => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Profile_Screen(
                                  uid: (snapshot.data! as dynamic).docs[index]['uid'],
                                ),
                              ),
                            ),*/
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]['photoUrl'],
                                ),
                                radius: 16,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]['username'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ),
            )
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Suggested",
                          style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFF393939),
                        ),
                        ),
                      ],
                  ),
                ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .orderBy('datePublished')
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 3,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                              return Container(
                                child:  snap['isPhoto'] != null
                                    ? snap['isPhoto'] == true
                                    ? Image.network(
                                  snap['postUrl'].toString(),
                                  fit: BoxFit.cover,
                                )
                                    : VideoPlayerProfile(
                                  videoUrl: snap['videoUrl'],
                                )
                                    : Image.network(
                                  snap['postUrl'].toString(),
                                  fit: BoxFit.cover,
                                ),
                                /* Image(
                          image: NetworkImage(snap['postUrl']),
                          fit: BoxFit.cover,
                        ),*/
                              );
                            },
                                /*Image.network(
                              (snapshot.data! as dynamic).docs[index]['postUrl'],
                              fit: BoxFit.cover,
                            ),*/
                            staggeredTileBuilder: (index) => MediaQuery.of(context)
                                        .size
                                        .width >
                                    webScreenSize
                                ? StaggeredTile.count(
                                    (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                                : StaggeredTile.count(
                                    (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          );
                        },
                      ),
                    ),
                  ),
                ],
            ),
        /*Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CupertinoSearchTextField(),
          ),
        ),*/
      ),
    );
  }
}
