import 'package:flutter/material.dart';
import 'package:guftago/utils/assets.dart';
import 'package:guftago/views/Onboarding/widget/onBoard_Content_Widget.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardContentWidget(
        image: assets.encryption,
        Title: 'Your Privacy, Our Priority',
        Description:
            'All your conversations are secure with end-to-end encryption.',
      ),
    );
  }
}
