part of 'messagebloc_socket_io_bloc.dart';

abstract class MessageblocSocketIoEvent {}

class ConnectToSocketEvent extends MessageblocSocketIoEvent {
  final String sourceId;

  ConnectToSocketEvent({required this.sourceId});
}

class SendMessageEvent extends MessageblocSocketIoEvent {
  final String message;
  final String sourceId;
  final String targetId;

  SendMessageEvent(
      {required this.message, required this.sourceId, required this.targetId});
}

class ReceiveMessageEvent extends MessageblocSocketIoEvent {
  final MessageModel messageModel;

  ReceiveMessageEvent({required this.messageModel});
}
