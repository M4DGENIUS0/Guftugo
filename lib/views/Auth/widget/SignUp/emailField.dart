import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/SignUp/signup_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../utils/validation.dart';

class EmailField extends StatefulWidget {
  final FocusNode Email;
  final TextEditingController email;

  const EmailField({
    super.key,
    required this.Email,
    required this.email,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (p, c) => c.email != p.email,
      builder: (context, state) {
        return TextFormField(
          controller: widget.email,
          focusNode: widget.Email,
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
              hintText: 'Email Here',
              hintStyle: TextStyle(color: Colors.blueGrey[600]),
              filled: true,
              fillColor: colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none)),
        );
      },
    );
  }
}
