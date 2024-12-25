part of 'message_screen_bloc.dart';

sealed class MessageScreenEvent extends Equatable {
  const MessageScreenEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends MessageScreenEvent {
  final String chatRoomID;
  final String content;
  final UserModel sender;
  final UserModel receiver;
  final DateTime time;

  const SendMessage({
    required this.content,
    required this.chatRoomID,
    required this.sender,
    required this.receiver,
    required this.time,
  });
  @override
  List<Object> get props => [chatRoomID, content, sender, receiver, time];
}

class GetMessages extends MessageScreenEvent {
  final String chatroomId;

  const GetMessages(this.chatroomId);

  @override
  List<Object> get props => [chatroomId];
}

class ClearInputEvent extends MessageScreenEvent {}
