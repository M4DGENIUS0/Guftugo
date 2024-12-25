import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color color;

  final Color fontcolor;
  final VoidCallback tap;
  const ButtonWidget({
    super.key,
    required this.title,
    required this.color,
    required this.tap,
    required this.fontcolor,
    // this.stroke
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
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
            style: TextStyle(
                color: fontcolor,
                fontFamily: 'Regular',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
