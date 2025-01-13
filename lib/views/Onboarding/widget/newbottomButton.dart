import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/Colors/colors.dart';
import '../../../config/routes/route_name.dart';

class BottomDescription extends StatelessWidget {
  const BottomDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: colors.Primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Gap(5),
          Text(
            "Welcome to Guftago",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Large",
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Join over 200 million people who use Textly to send messages with family, friends and communities.",
              softWrap: true,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Regular",
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Route_Name.AuthScreen,
                    (route) => false,
                  );
                },
                child: Text(
                  "Get Started",
                  style: const TextStyle(
                      color: colors.black, fontFamily: 'Regular', fontSize: 16),
                )),
          ),
          Text(
            "By tapping “Get Started”, you have read to our Privacy Policy. And you agree to our Terms and Services. ",
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Light",
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
