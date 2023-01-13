import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone/resources/storage_methods.dart';

import '../models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  //login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String result = "Failed to login";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List file}) async {
    String res = "An error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          userName.isNotEmpty &&
          bio.isNotEmpty) {
        final UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl =
            await StorageMethod().uploadImg('profilePics', file, false);

        CustomUser user = CustomUser(
            email: email,
            uid: cred.user!.uid,
            userName: userName,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: downloadUrl);

        await _fs.collection('users').doc(cred.user!.uid).set(user.toJSON());

        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = "Password should be atleast 6 characters long";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
