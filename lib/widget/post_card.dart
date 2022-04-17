import 'package:concept/widget/utils.dart';
import 'package:concept/widget/video_player_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:concept/model/users.dart' as model;
import '../providers/user_providers.dart';
import '../resources/firestore_methods.dart';
import '../screens/comments_screen.dart';
import 'gradient_icon.dart';
import 'like_animating.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  bool isPhoto = true;

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    // final width = MediaQuery.of(context).size.width;

    return Container(
      // boundary needed for web
      // decoration: BoxDecoration(
      //   color: Colors.black,
      // ),
      // padding: const EdgeInsets.symmetric(
      //   vertical: 10,
      // ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'].toString(),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.93,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ? IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      deletePost(
                                        widget.snap['postId'].toString(),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  )
                                ],
                                // child: ListView(
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 16),
                                //     shrinkWrap: true,
                                //     children: [
                                //       'Delete',
                                //       'Save',
                                //     ]
                                //         .map(
                                //           (e) => InkWell(
                                //               child: Container(
                                //                 padding:
                                //                     const EdgeInsets.symmetric(
                                //                         vertical: 12,
                                //                         horizontal: 16),
                                //                 child: Text(e),
                                //               ),
                                //               onTap: () {
                                //                 deletePost(
                                //                   widget.snap['postId']
                                //                       .toString(),
                                //                 );
                                //                 // remove the dialog box
                                //                 Navigator.of(context).pop();
                                //               }),
                                //         )
                                //         .toList()),
                              );
                            },
                          );
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().likePost(
                widget.snap['postId'].toString(),
                FirebaseAuth.instance.currentUser!.uid.toString(),
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    child: widget.snap['isPhoto'] != null
                        ? widget.snap['isPhoto'] == true
                        ? Image.network(
                      widget.snap['postUrl'].toString(),
                      fit: BoxFit.cover,
                    )
                        : VideoPlayerItem(
                      videoUrl: widget.snap['videoUrl'],
                    )
                        : Image.network(
                      widget.snap['postUrl'].toString(),
                      fit: BoxFit.cover,
                    )),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    child: GradientIcon(
                      Icons.star_rate_outlined,
                      100,
                      LinearGradient(
                        colors: <Color>[
                          Color(0XFF28B6ED),
                          Color(0XFFFA0AFF),
                        ],
                      ),
                    ),
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? GradientIcon(
                          Icons.star,
                          30,
                          LinearGradient(
                            colors: <Color>[
                              Color(0XFFFA0AFF),
                              Color(0XFF28B6ED),
                            ],
                          ),
                        ) /*GIcon(
                          Icons.star_border,
                          color: Colors.pinkAccent,
                        )*/
                      : const Icon(
                          Icons.star_border,
                        ),
                  onPressed: () => FireStoreMethods().likePost(
                    widget.snap['postId'].toString(),
                    FirebaseAuth.instance.currentUser!.uid.toString(),
                    user.uid,
                    widget.snap['likes'],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_bank_rounded,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.snap['postId'].toString(),
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.ios_share,
                  ),
                  onPressed: () {}),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              ))
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: widget.snap['username'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['caption']}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Text(
                      'View all $commentLen comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
