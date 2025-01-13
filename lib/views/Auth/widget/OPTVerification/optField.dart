import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guftago/config/Colors/colors.dart';

class OPTField extends StatelessWidget {
  // final FocusNode optNode;
  const OPTField({
    super.key,
    // required this.optNode
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        // focusNode: optNode,
        onSaved: (pin1) {},
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(fontFamily: 'Regular', fontSize: 15),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '0',
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: colors.Primary)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: colors.Primary)),
        ),
      ),
    );
  }
}
