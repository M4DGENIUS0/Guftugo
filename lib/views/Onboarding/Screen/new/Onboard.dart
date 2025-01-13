import 'package:flutter/material.dart';
import 'package:guftago/utils/assets.dart';

import '../../widget/newbottomButton.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assets.bg1),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assets.avatar),
              ),
            ))),
            BottomDescription()
          ],
        ),
      ),
    );
  }
}
