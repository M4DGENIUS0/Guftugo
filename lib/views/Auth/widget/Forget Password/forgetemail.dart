import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../utils/validation.dart';

class ForgetEmailField extends StatelessWidget {
  final FocusNode ForgetEmail;
  const ForgetEmailField({super.key, required this.ForgetEmail});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: ForgetEmail,
      validator: (v) {
        if (v!.isEmpty) {
          return 'Enter Email';
        }
        final validation = Validation();
        if (!validation.emailValidator(v)) {
          return 'Email is not correct';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIconColor: Colors.blueGrey[600],
          prefixIcon: const Icon(Icons.email),
          hintText: 'Enter your Forgotten Email',
          hintStyle: TextStyle(color: Colors.blueGrey[600]),
          filled: true,
          fillColor: colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)),
    );
  }
}
