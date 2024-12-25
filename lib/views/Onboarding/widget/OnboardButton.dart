import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class OnboardButton extends StatelessWidget {
  final String title;
  final Color color;
  // final Color? stroke;
  final VoidCallback tap;
  const OnboardButton(
      {super.key,
      required this.title,
      required this.color,
      // this.stroke,
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: colors.black, strokeAlign: 2))),
          onPressed: tap,
          child: Text(
            title,
            style: const TextStyle(
                color: colors.black, fontFamily: 'Regular', fontSize: 15),
          )),
    );
  }
}
