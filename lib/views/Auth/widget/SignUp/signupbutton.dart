import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/SignUp/signup_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../Domain/model/model.dart';
import '../../../../config/components/toast.dart';
import '../../../../config/routes/route_name.dart';

class SignUpButton extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;

  final formkey;
  const SignUpButton(
      {super.key,
      this.formkey,
      required this.name,
      required this.email,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pushNamed(
            context,
            Route_Name.Profile,
          );
        } else if (state is SignupFailure) {
          String error = state.message;
          showCustomToast(context, error);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
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
                    ? null // Disable button while loading
                    : () {
                        if (formkey.currentState!.validate()) {
                          UserModel user = UserModel.empty.copyWith(
                            name: name.text,
                            email: email.text,
                          );

                          context
                              .read<SignupBloc>()
                              .add(SubmitEvent(user, password.text));
                        }
                      },
                child: state.load
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Sign Up',
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
