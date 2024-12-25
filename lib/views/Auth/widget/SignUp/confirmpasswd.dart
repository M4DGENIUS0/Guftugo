import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/SignUp/signup_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Confirmpasswordfield extends StatefulWidget {
  final FocusNode Confirmpasswd;
  const Confirmpasswordfield({super.key, required this.Confirmpasswd});

  @override
  State<Confirmpasswordfield> createState() => _ConfirmpasswordfieldState();
}

class _ConfirmpasswordfieldState extends State<Confirmpasswordfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: widget.Confirmpasswd,
          obscureText: state.unhidee,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Enter Password';
            }
            print(state.passwd.toString());
            if (v != state.passwd) {
              return 'Password doesn\'t match';
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    context.read<SignupBloc>().add(ConfirmPasswdUnhide());
                  },
                  child: Icon(
                      state.unhidee ? Icons.visibility : Icons.visibility_off)),
              suffixIconColor: Colors.blueGrey[600],
              prefixIconColor: Colors.blueGrey[600],
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              hintText: 'Confirm Password Here',
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
