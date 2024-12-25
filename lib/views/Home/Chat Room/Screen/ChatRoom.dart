import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/views/views.dart';

import '../../../../Domain/model/model.dart';
import '../../../../bloc/MessageScreen/message_screen_bloc.dart';
import '../../../../bloc/RealTimeChatUserList/real_time_chat_user_list_bloc.dart';
import '../../../../config/components/toast.dart';

class Chatroom extends StatefulWidget {
  final String chatroomID;
  final ChatViewModel chatViewModel;
  final String username;
  const Chatroom({
    super.key,
    required this.username,
    required this.chatroomID,
    required this.chatViewModel,
  });

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: colors.black,
          ),
        ),
        title: BlocBuilder<RealTimeChatUserListBloc, RealTimeChatUserListState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(
                child: LinearProgressIndicator(
                  color: colors.black,
                ),
              );
            } else if (state is UsersError) {
              showCustomToast(context, "Error: ${state.message}");
              return const SizedBox(); // Return an empty widget
            } else if (state is UsersLoaded) {
              return Hero(
                tag: "name",
                child: Text(
                  widget.username,
                  style: const TextStyle(
                    color: colors.black,
                    fontFamily: 'Regular',
                  ),
                ),
              );
            } else {
              return const Text(
                "N/A",
                style: TextStyle(
                  color: colors.black,
                  fontFamily: 'Regular',
                ),
              );
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: colors.black,
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => MessageScreenBloc(widget.chatViewModel.chatservice)
          ..add(GetMessages(widget.chatViewModel.ChatRoomID)),
        child: Column(
          children: [
            BlocBuilder<MessageScreenBloc, MessageScreenState>(
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is MessagesLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        // print(state.messages.length);
                        final message = state.messages[index];
                        print(message);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chatbubble(
                            isCurrent: false,
                            content: message.content ?? "",
                            time: message.timestamp ?? "",
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is MessagesError) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: colors.black,
                            size: 30,
                          ),
                          Text(state.error,
                              style: const TextStyle(
                                  color: colors.black, fontFamily: 'Regular'))
                        ],
                      ),
                    ),
                  );
                } else if (state is MessageScreenInitial) {
                  return const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: colors.black,
                            size: 30,
                          ),
                          Text("Start Messaging",
                              style: TextStyle(
                                  color: colors.black, fontFamily: 'Regular'))
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                      child: Center(child: Text("Nothing to show")));
                }
              },
            ),
            BottomMessageField(
              controller: widget.chatViewModel.controller,
              ChatroomId: widget.chatViewModel.ChatRoomID,
              sender: widget.chatViewModel.currentUser,
              reciever: widget.chatViewModel.reciever,
            )
          ],
        ),
      ),
    );
  }
}
