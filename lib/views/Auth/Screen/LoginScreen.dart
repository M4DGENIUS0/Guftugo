/* 
  -----------------------------------------------------------------------
                              Login Screen
  
    This screen is used to access user account.
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/config/routes/route_name.dart';

import '../widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwd = TextEditingController();
  TextEditingController email = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwdFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  // late LoginBloc _LoginBloc;
  // late UserRepository userRepository;
  @override
  void initState() {
    // TODO: implement initState
    email.clear();
    passwd.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hey,Welcome Back!',
                    style: TextStyle(fontFamily: "Large", fontSize: 25)),
                const Text(
                    'Log in to continue where you left off and stay connected.',
                    style: TextStyle(
                        fontFamily: "Regular",
                        fontSize: 18,
                        color: colors.lightGrey)),
                const Gap(50),
                Emailfield(
                  Email: emailFocusNode,
                  email: email,
                ),
                const SizedBox(
                  height: 10,
                ),
                Passwordfield(
                  passwd: passwdFocusNode,
                  password: passwd,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Route_Name.ForgotScreen);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontFamily: 'Light'),
                      )),
                ),
                const Gap(30),
                Center(
                  child: LoginButton(
                    formkey: _formkey,
                    email: email,
                    passwd: passwd,
                  ),
                ),
                const Gap(50),
                const Center(
                  child: Text('Else',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Light')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
