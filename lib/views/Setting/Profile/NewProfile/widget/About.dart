import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.info_outline,
            color: colors.black,
          ),
          SizedBox(
            height: 80,
            width: 280,
            child: TextField(
              scrollPhysics: const BouncingScrollPhysics(),
              keyboardType: TextInputType.multiline,
              maxLines: 140,
              minLines: 4,
              onTapOutside: (v) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              cursorColor: colors.black,
              decoration: InputDecoration(
                  labelText: "About",
                  labelStyle: const TextStyle(
                      fontFamily: "Regular", color: colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: colors.Primary, strokeAlign: 5),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: colors.black),
                      borderRadius: BorderRadius.circular(15))),
            ),
          )
        ],
      ),
    );
  }
}
