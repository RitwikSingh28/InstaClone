import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone/models/post_model.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List file, String description, String uid,
      String username, String profileImage) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethod().uploadImg('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now().toString(),
          postUrl: photoUrl,
          profImage: profileImage,
          likes: []);

      await _firestore.collection('posts').doc(postId).set(post.toJSON());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}