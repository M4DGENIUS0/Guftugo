import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/SignUp/signup_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/utils/validation.dart';

class nameField extends StatefulWidget {
  final FocusNode nameNode;
  final TextEditingController name;

  const nameField({super.key, required this.name, required this.nameNode});

  @override
  State<nameField> createState() => _nameFieldState();
}

class _nameFieldState extends State<nameField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.name,
          focusNode: widget.nameNode,
          validator: (v) {
            if (v!.isEmpty) {
              return 'Enter Name';
            }

            Validation validation = Validation();
            List<String> validationMessages = validation.nameValidator(v);
            if (validationMessages.isNotEmpty) {
              for (String message in validationMessages) {
                return "- $message";
              }
            }
            return null;
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              prefixIconColor: Colors.blueGrey[600],
              prefixIcon: const Icon(Icons.person_2_rounded),
              hintText: 'Name Here',
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
