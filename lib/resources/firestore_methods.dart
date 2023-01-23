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

  Future<void> likePost(
    String postId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> postComment(
    String postId,
    String text,
    String uid,
    String username,
    String profilePic,
  ) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = "success";
      } else {
        res = "Add some comments dammit!";
      }
    } catch (err) {
      print(err.toString());
      res = err.toString();
    }

    return res;
  }

  Future<String> deletePost(String postId) async {
    String res = "Some error occured";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = "deleted";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
