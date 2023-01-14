import 'package:cloud_firestore/cloud_firestore.dart';

class CustomUser {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  CustomUser(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.userName,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "uid": uid,
      "userName": userName,
      "photoUrl": photoUrl,
      "bio": bio,
      "followers": followers,
      "following": following,
    };
  }

  static CustomUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CustomUser(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        userName: snapshot['userName']);
  }
}
