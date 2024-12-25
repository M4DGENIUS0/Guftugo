import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';

import '../../../../Domain/model/Messages/messages.dart';
import '../../../../Domain/model/model.dart';
import '../../../../bloc/MessageScreen/message_screen_bloc.dart';

class BottomMessageField extends StatelessWidget {
  final String ChatroomId;
  final TextEditingController controller;
  final UserModel sender;
  final UserModel reciever;
  const BottomMessageField(
      {super.key,
      required this.ChatroomId,
      required this.controller,
      required this.sender,
      required this.reciever});

  @override
  Widget build(BuildContext context) {
    const double radius = 25;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const InkWell(
              child: CircleAvatar(
            radius: 20,
            backgroundColor: colors.white,
            child: Icon(
              Icons.add,
              color: colors.black,
            ),
          )),
          SizedBox(
            width: 300,
            child: TextField(
              controller: controller,
              onTapOutside: (v) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 50,
              cursorColor: colors.black,
              // expands: true,
              scrollPhysics: const BouncingScrollPhysics(),
              style: const TextStyle(
                fontFamily: "Regular",
                color: colors.black,
              ),
              decoration: InputDecoration(
                  fillColor: colors.white,
                  filled: true,
                  // Send Message Button Here
                  suffixIcon: IconButton(
                      onPressed: () {
                        final messageContent = controller.text;
                        if (messageContent.isNotEmpty) {
                          context.read<MessageScreenBloc>().add(SendMessage(
                                chatRoomID: ChatroomId,
                                content: messageContent,
                                sender: sender,
                                receiver: reciever,
                                time: DateTime.now(),
                              ));
                          controller.clear();
                        }
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundColor: colors.green,
                        child: Icon(
                          Icons.send_rounded,
                          color: colors.black,
                        ),
                      )),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          )
        ],
      ),
    );
  }
}
