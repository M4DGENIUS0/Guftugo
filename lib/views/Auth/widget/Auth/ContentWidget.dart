import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';

class ContentWidget extends StatelessWidget {
  final String Title;
  final String welcome;

  final String Description;
  final String image;
  const ContentWidget(
      {super.key,
      required this.Title,
      required this.Description,
      required this.image,
      required this.welcome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(40),
          SvgPicture.asset(
            width: 200,
            height: 200,
            image,
            semanticsLabel: Title,
          ),
          const SizedBox(height: 40),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                  text: welcome,
                  style: const TextStyle(
                      fontFamily: "Large", fontSize: 30, color: colors.black)),
              TextSpan(
                  text: Title,
                  style: TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = colors.black,
                      backgroundColor: colors.green,
                      fontFamily: "Large",
                      fontSize: 30,
                      // color: colors.green,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '\n$Description',
                  style: const TextStyle(
                      fontFamily: "Regular",
                      fontSize: 25,
                      color: colors.black)),
            ]),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
