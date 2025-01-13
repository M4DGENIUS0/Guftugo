/* 
  -----------------------------------------------------------------------
                              Home Screen
  
    This screen is used to display to chats and more things.
  -----------------------------------------------------------------------  
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/config/routes/route_name.dart';
import 'package:guftago/views/views.dart';

import '../../bloc/Login/login_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Route_Name.AuthScreen,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colors.Primary,
            title: const Text("Guftago",
                style: TextStyle(
                    fontFamily: "Large",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3)),
            centerTitle: true,
          ),
          drawer: const CustomDrawer(),
          body: Container(
            color: colors.Primary,
            child: Column(
              // spacing: 5,
              children: [
                Gap(30),
                SearchEngine(),
                Gap(10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        Gap(10),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text("Chatting",
                                  style: TextStyle(
                                    fontFamily: "Regular",
                                    fontSize: 21,
                                  )),
                            )),
                        Chatlist(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
