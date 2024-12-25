import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/Login/login_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../utils/validation.dart';

class Emailfield extends StatefulWidget {
  final TextEditingController email;

  final FocusNode Email;
  const Emailfield({super.key, required this.Email, required this.email});

  @override
  State<Emailfield> createState() => _EmailfieldState();
}

class _EmailfieldState extends State<Emailfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (p, c) => c.email != p.email,
      builder: (context, state) {
        return TextFormField(
          controller: widget.email,
          focusNode: widget.Email,
          onChanged: (v) {
            context.read<LoginBloc>().add(EmailFieldEvent(email: v));
          },
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
