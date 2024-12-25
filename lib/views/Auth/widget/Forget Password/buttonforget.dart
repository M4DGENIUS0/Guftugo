import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../config/routes/route_name.dart';

class ForgetEmailButton extends StatelessWidget {
  final formkey;
  const ForgetEmailButton({super.key, this.formkey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.black, strokeAlign: 2))),
          onPressed: () {
            Navigator.pushNamed(context, Route_Name.VerifyScreen);
            if (formkey.currentState!.validate()) {}
          },
          child: const Text(
            'Change Password',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colors.black,
                fontFamily: 'Regular',
                fontSize: 18),
          )),
    );
  }
}
