/* 
  -----------------------------------------------------------------------
                              Verify Screen
  
    This screen is used to verify user email/phone number to sign in, associated with Sign in.
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../widget/widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  final _formkey = GlobalKey<FormState>();
  final OPTNode = FocusNode();
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
              const Text('Verify Your Email',
                  style: TextStyle(fontFamily: "Large", fontSize: 25)),
              const Text(
                  'Check your inbox for a verification link to activate your account.',
                  style: TextStyle(
                      fontFamily: "Regular",
                      fontSize: 18,
                      color: colors.lightGrey)),
              const Gap(30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OPTField(
                      // optNode: OPTNode,
                      ),
                  OPTField(
                      // optNode: OPTNode,
                      ),
                  OPTField(
                      // optNode: OPTNode,
                      ),
                  OPTField(
                      // optNode: OPTNode,
                      ),
                ],
              ),
              // const Gap(20),
              Center(
                child: ConfirmOPT(
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
