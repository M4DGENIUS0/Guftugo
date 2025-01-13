import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class ConfirmOPT extends StatelessWidget {
  final formkey;
  const ConfirmOPT({super.key, this.formkey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colors.Primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.black, strokeAlign: 2))),
          onPressed: () {
            if (formkey.currentState!.validate()) {}
          },
          child: const Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colors.black,
                fontFamily: 'Regular',
                fontSize: 18),
          )),
    );
  }
}
