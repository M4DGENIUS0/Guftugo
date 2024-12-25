import 'package:flutter/material.dart';
import 'package:guftago/utils/assets.dart';
import 'package:guftago/views/Onboarding/widget/onBoard_Content_Widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardContentWidget(
        image: assets.loved_ones,
        Title: 'Share Moments that Matter',
        Description:
            'Easily chat with friends and family to stay close, even when apart.',
      ),
    );
  }
}
