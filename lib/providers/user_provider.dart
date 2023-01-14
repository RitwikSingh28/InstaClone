import 'package:flutter/foundation.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  CustomUser? _user;
  final AuthMethods _auth = AuthMethods();

  CustomUser get getUser => _user!;

  Future<void> refreshUser() async {
    CustomUser user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
