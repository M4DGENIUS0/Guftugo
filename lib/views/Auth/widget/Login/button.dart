import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../bloc/Login/login_bloc.dart';
import '../../../../config/components/toast.dart';
import '../../../../config/routes/route_name.dart';

class LoginButton extends StatelessWidget {
  final formkey;
  final TextEditingController email;
  final TextEditingController passwd;
  const LoginButton(
      {super.key, this.formkey, required this.email, required this.passwd});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // final authIndicator = context.read<AuthCircularProgressIndicator>();
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Route_Name.Home,
            (route) => false,
          );
        } else if (state is LoginFailure) {
          String error = state.message;
          showCustomToast(context, error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: Colors.black, strokeAlign: 2))),
                onPressed: state.load
                    ? () {} // Disable button while loading
                    : () {
                        if (formkey.currentState!.validate()) {
                          context.read<LoginBloc>().add(SubmitEvent(
                              email: email.text, passwd: passwd.text));
                        }
                      },
                child: state.load
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colors.black,
                            fontFamily: 'Regular',
                            fontSize: 18),
                      )),
          );
        },
      ),
    );
  }
}
