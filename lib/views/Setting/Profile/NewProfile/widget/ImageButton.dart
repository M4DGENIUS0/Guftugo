import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class Buttons_Image extends StatelessWidget {
  final IconData icon;
  final String title;
  const Buttons_Image({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: colors.Primary),
          child: Icon(
            icon,
            color: colors.black,
            size: 30,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontFamily: 'Light', color: Colors.black),
        )
      ],
    );
  }
}
