import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/SignUp/signup_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guftago/utils/validation.dart';

class passwordfield extends StatefulWidget {
  final FocusNode passwd;
  final TextEditingController password;

  const passwordfield(
      {super.key, required this.passwd, required this.password});

  @override
  State<passwordfield> createState() => _passwordfieldState();
}

class _passwordfieldState extends State<passwordfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.password,
          focusNode: widget.passwd,
          obscureText: state.unhide,
          onChanged: (v) {
            context.read<SignupBloc>().add(PasswordFieldEvent(passwd: v));
          },
          validator: (v) {
            Validation validation = Validation();
            List<String> validationMessages = validation.passwordValidator(v!);
            if (v.isEmpty) {
              return 'Enter Password';
            }
            if (v.length < 8) {
              return 'Password is too Short';
            }
            if (validationMessages.isNotEmpty) {
              for (String message in validationMessages) {
                return message;
              }
            }

            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    context.read<SignupBloc>().add(PasswdUnhide());
                  },
                  child: Icon(
                      state.unhide ? Icons.visibility : Icons.visibility_off)),
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
