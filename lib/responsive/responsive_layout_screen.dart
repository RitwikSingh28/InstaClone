import 'package:flutter/material.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // if (constraints.maxWidth > webScreenSize) {
      //   //web screen layout
      //   return webScreenLayout;
      // } else {
      //   //mobile screen layout
      //   return mobileScreenLayout;
      // }
      return const SignUpScreen();
    });
  }
}
