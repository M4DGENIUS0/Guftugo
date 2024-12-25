import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OnBoardContentWidget extends StatelessWidget {
  final String Title;
  final String Description;
  final String image;
  const OnBoardContentWidget(
      {super.key,
      required this.Title,
      required this.Description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(40),
            SvgPicture.asset(
              width: 300,
              height: 300,
              image,
              semanticsLabel: Title,
            ),
            const SizedBox(height: 20),
            Text(Title,
                style: const TextStyle(fontFamily: "Large", fontSize: 30)),
            const SizedBox(height: 10),
            Text(Description,
                style: const TextStyle(fontFamily: "Regular", fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
