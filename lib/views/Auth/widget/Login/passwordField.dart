import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/Login/login_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guftago/utils/validation.dart';

class Passwordfield extends StatefulWidget {
  final TextEditingController password;
  final FocusNode passwd;
  const Passwordfield(
      {super.key, required this.passwd, required this.password});

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (p, c) => p.passwd != c.passwd,
      builder: (context, state) {
        return TextFormField(
          controller: widget.password,
          focusNode: widget.passwd,
          obscureText: state.unhide,
          onChanged: (v) {
            context.read<LoginBloc>().add(PasswordFieldEvent(passwd: v));
          },
          validator: (v) {
            Validation validation = Validation();
            List<String> validationMessages = validation.passwordValidator(v!);
            if (v.isEmpty) {
              return 'Enter Password';
            }
            if (v.length < 8) {
              return 'Password is less then 8';
            }
            if (validationMessages.isNotEmpty) {
              for (String message in validationMessages) {
                return "- $message";
              }
            }

            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(PasswdUnhide());
                    print(state.unhide);
                  },
                  icon: Icon(
                      state.unhide ? Icons.visibility_off : Icons.visibility)),
              suffixIconColor: Colors.blueGrey[600],
              prefixIconColor: Colors.blueGrey[600],
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              hintText: 'Password Here',
              hintStyle: TextStyle(color: Colors.blueGrey[600]),
              filled: true,
              fillColor: colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15))),
        );
      },
    );
  }
}
