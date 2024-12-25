/* 
  -----------------------------------------------------------------------
                              Splash Screen
  
    This screen is used to display splash everytime the app open
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:guftago/service/Splash%20Service/service_Splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService service = SplashService();

  // late AuthStateBloc authStateBloc;

  @override
  void initState() {
    // authStateBloc =
    // AuthStateBloc(UserRepository: context.read<AuthStateBloc>().userRepo);
    // service.checkAuthentication(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          ".گفتگو",
          style: TextStyle(
              fontFamily: "Urdu2",
              fontSize: 55,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}
