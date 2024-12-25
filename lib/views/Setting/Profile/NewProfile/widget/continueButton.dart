import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../../Cubit/ProfileScreenCubit.dart';
import '../../../../../utils/status/status.dart';

class ContinueButton extends StatefulWidget {
  final String title;
  final VoidCallback Tap;
  const ContinueButton({super.key, required this.title, required this.Tap});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  ButtonState state = ButtonState.init;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileScreenCubit, ButtonState>(
      builder: (context, state) {
        return InkWell(
            onTap: widget.Tap,
            child: Container(
              // width: 200,
              decoration: BoxDecoration(
                color:
                    state == ButtonState.loading ? Colors.green : colors.green,
                border:
                    Border.all(strokeAlign: 1, color: colors.black, width: 2),
                borderRadius: state == ButtonState.loading
                    ? BorderRadius.circular(50)
                    : BorderRadius.circular(15),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                width: state == ButtonState.loading ? 50 : width,
                height: 40,
                child: state == ButtonState.loading
                    ? smallLoading(true)
                    : Button(),
              ),
            ));
      },
    );
  }

  Widget smallLoading(bool isDone) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: isDone
          ? const Icon(
              Icons.done,
              color: colors.black,
              size: 30,
            )
          : const CircularProgressIndicator(
              color: colors.black,
            ),
    );
  }

  Widget Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              color: colors.black, fontFamily: "Light", fontSize: 20),
        ),
        // const Gap(20),
        const Icon(
          Icons.arrow_forward,
          color: colors.black,
          size: 25,
        )
      ],
    );
  }
}
