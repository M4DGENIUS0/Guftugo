/* 
  -----------------------------------------------------------------------
                              Sign Up Screen
  
    This screen is used for registering new user.
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guftago/views/Auth/widget/widget.dart';
import '../../../config/Colors/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwdFocusNode = FocusNode();
  final confirmpasswdNode = FocusNode();
  final nameNode = FocusNode();
  @override
  void initState() {
    name.clear();
    email.clear();
    password.clear();
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
                const Text('Create an Account',
                    style: TextStyle(fontFamily: "Large", fontSize: 25)),
                const Text(
                    'Join us today and experience seamless communication.',
                    style: TextStyle(
                        fontFamily: "Regular",
                        fontSize: 18,
                        color: colors.lightGrey)),
                const Gap(50),
                nameField(
                  nameNode: nameNode,
                  name: name,
                ),
                const SizedBox(
                  height: 10,
                ),
                EmailField(
                  Email: emailFocusNode,
                  email: email,
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordfield(
                  passwd: passwdFocusNode,
                  password: password,
                ),
                const SizedBox(
                  height: 10,
                ),
                Confirmpasswordfield(
                  Confirmpasswd: confirmpasswdNode,
                ),
                const Gap(40),
                Center(
                  child: SignUpButton(
                    formkey: _formkey,
                    name: name,
                    email: email,
                    password: password,
                  ),
                ),
                const Gap(20),
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
