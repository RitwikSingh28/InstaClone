import 'package:flutter/material.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    CustomUser user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: Text(user.userName),
        ),
      ),
    );
  }
}
