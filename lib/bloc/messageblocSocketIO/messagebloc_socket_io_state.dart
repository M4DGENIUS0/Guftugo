part of 'messagebloc_socket_io_bloc.dart';

abstract class MessageblocSocketIoState {}

class ChatInitial extends MessageblocSocketIoState {}

class ChatConnecting extends MessageblocSocketIoState {}

class ChatMessageReceived extends MessageblocSocketIoState {
  final List<MessageModel> messages;

  ChatMessageReceived({required this.messages});
}
