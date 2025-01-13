import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/views/views.dart';

import '../../../../Domain/model/Chat View Model/chatviewmodel.dart';
import '../../../../bloc/MessageScreen/message_screen_bloc.dart';
import '../../../../bloc/RealTimeChatUserList/real_time_chat_user_list_bloc.dart';
import '../../../../bloc/messageblocSocketIO/messagebloc_socket_io_bloc.dart';
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
  void initState() {
    super.initState();
    context.read<MessageblocSocketIoBloc>().add(ConnectToSocketEvent(
        sourceId: widget.chatViewModel.currentUser.id.toString()));
  }

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
      body: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<MessageblocSocketIoBloc, MessageblocSocketIoState>(
              builder: (context, state) {
                if (state is ChatConnecting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatMessageReceived) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chatbubble(
                          content: message.message,
                          time: DateTime.parse(message.time),
                          isCurrent: message.type == "source",
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Connecting..."));
                }
              },
            ),
          ),
          BottomMessageField(
            controller: widget.chatViewModel.controller,
            ChatroomId: widget.chatViewModel.ChatRoomID,
            sender: widget.chatViewModel.currentUser,
            reciever: widget.chatViewModel.reciever,
          ),
        ],
      ),
    );
  }
}
