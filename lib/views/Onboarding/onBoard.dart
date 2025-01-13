import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/bloc/OnBoard/on_board_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/views/views.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/routes/route_name.dart';

class onBoardScreen extends StatefulWidget {
  const onBoardScreen({super.key});

  @override
  State<onBoardScreen> createState() => _onBoardScreenState();
}

class _onBoardScreenState extends State<onBoardScreen> {
  final PageController _controller = PageController();
  bool changeName = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OnBoardBloc(),
        child: Scaffold(body: BlocBuilder<OnBoardBloc, OnBoardState>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView(
                  physics: const PageScrollPhysics(),
                  onPageChanged: (index) {
                    context
                        .read<OnBoardBloc>()
                        .add(PageisChanged(isChange: index == 2));
                    changeName = (index == 2);
                  },
                  controller: _controller,
                  children: const [
                    FirstScreen(),
                    SecondScreen(),
                    ThirdScreen()
                  ],
                ),
                Container(
                  alignment: const Alignment(0, 0.80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            // _controller.jumpToPage(3);
                            _controller.animateToPage(3,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          },
                          child: state.isChange
                              ? const Text('')
                              : const Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      color: colors.black,
                                      fontSize: 15),
                                )),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: colors.Primary,
                            dotColor: Colors.grey.shade300,
                            dotHeight: 10.0,
                            dotWidth: 10.0),
                      ),
                      state.isChange
                          ? OnboardButton(
                              title: 'Confirm',
                              color: colors.Primary,
                              tap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Route_Name.AuthScreen,
                                  (route) => false,
                                );
                              },
                            )
                          : OnboardButton(
                              title: 'Next',
                              color: colors.Primary,
                              tap: () {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        )));
  }
}
