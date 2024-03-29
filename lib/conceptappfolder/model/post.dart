import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final String id;
  final String songName;
  final String caption;
  final bool isPhoto;
  final String videoUrl;
  final String audioUrl;

  const Post( {
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.id,
    required this.songName,
    required this.caption,
    required this.isPhoto,
    required this.videoUrl,
    required this.audioUrl,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      id: snapshot['id'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      isPhoto: snapshot['isPhoto'],
      videoUrl: snapshot['videoUrl'],
      audioUrl: snapshot['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "id": id,
        "songName": songName,
        "caption": caption,
        "isPhoto": isPhoto,
        "videoUrl": videoUrl,
        "audioUrl": audioUrl,
      };
}
