/* 
  -----------------------------------------------------------------------
                              Auth Screen
  
    This screen is use to display two Option Signin/Login and Sign Up
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/config/routes/route_name.dart';
import 'package:guftago/utils/assets.dart';

import '../views.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(30),
          const ContentWidget(
            welcome: 'Welcome to ',
            Title: 'گفتگو',
            image: assets.account,
            Description: 'Start Your Journey\nJoin or Reconnect',
          ),
          const Gap(100),
          ButtonWidget(
            title: 'Login',
            color: colors.Primary,
            tap: () {
              Navigator.pushNamed(
                context,
                Route_Name.LoginScreen,
              );
            },
            fontcolor: colors.black,
          ),
          const Gap(20),
          ButtonWidget(
            title: 'Sign Up',
            color: colors.white,
            tap: () {
              Navigator.pushNamed(
                context,
                Route_Name.SignupScreen,
              );
            },
            fontcolor: colors.black,
          )
        ],
      ),
    );
  }
}
