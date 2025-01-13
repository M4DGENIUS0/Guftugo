import 'package:flutter/material.dart';
import 'package:guftago/config/routes/route_name.dart';
import 'package:guftago/views/Onboarding/onBoard.dart';
import 'package:guftago/views/views.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Route_Name.SplashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Route_Name.onBoard:
        return MaterialPageRoute(
          builder: (context) => const Onboard(),
        );
      case Route_Name.AuthScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
      case Route_Name.LoginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Route_Name.SignupScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );
      case Route_Name.Home:
        return PageTransition(
          child: Home(),
          type: PageTransitionType.fade,
        );
      case Route_Name.FirstScreen:
        return MaterialPageRoute(
          builder: (context) => const FirstScreen(),
        );
      case Route_Name.VerifyScreen:
        return MaterialPageRoute(
          builder: (context) => const VerifyScreen(),
        );

      case Route_Name.SecondScreen:
        return MaterialPageRoute(
          builder: (context) => const SecondScreen(),
        );
      case Route_Name.ThirdScreen:
        return MaterialPageRoute(
          builder: (context) => const ThirdScreen(),
        );
      case Route_Name.ForgotScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswdScreen(),
        );
      case Route_Name.Profile:
        return MaterialPageRoute(
          builder: (context) => const CreateNewProfile(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("Error 404\n Page Not found"),
              ),
            );
          },
        );
    }
  }
}
