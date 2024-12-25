import 'package:flutter/material.dart';
import 'package:guftago/utils/assets.dart';
import 'package:guftago/views/Onboarding/widget/onBoard_Content_Widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardContentWidget(
        image: assets.Chatting,
        Title: 'Stay Connected Instantly',
        Description:
            'Send and receive messages in the blink of an eye, no matter where you are.',
      ),
    );
  }
}
