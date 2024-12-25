import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guftago/views/Auth/widget/widget.dart';

import '../../../config/Colors/colors.dart';

class ForgotPasswdScreen extends StatefulWidget {
  const ForgotPasswdScreen({super.key});

  @override
  State<ForgotPasswdScreen> createState() => _ForgotPasswdScreenState();
}

class _ForgotPasswdScreenState extends State<ForgotPasswdScreen> {
  final ForgetEmail = FocusNode();
  final _formkey = GlobalKey<FormState>();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Forgot Your Password?',
                  style: TextStyle(fontFamily: "Large", fontSize: 25)),
              const Text(
                  'Don’t worry! Enter your email, and we’ll help you reset it.',
                  style: TextStyle(
                      fontFamily: "Regular",
                      fontSize: 18,
                      color: colors.lightGrey)),
              const Gap(20),
              ForgetEmailField(
                ForgetEmail: ForgetEmail,
              ),
              const Gap(30),
              Center(
                child: ForgetEmailButton(
                  formkey: _formkey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
