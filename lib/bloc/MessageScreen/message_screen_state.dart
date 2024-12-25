part of 'message_screen_bloc.dart';

sealed class MessageScreenState extends Equatable {
  const MessageScreenState();

  @override
  List<Object> get props => [];
}

final class MessageScreenInitial extends MessageScreenState {}

class MessagesLoading extends MessageScreenState {}

class MessagesLoaded extends MessageScreenState {
  final List<dynamic> messages;

  const MessagesLoaded(this.messages);
  @override
  List<Object> get props => [messages];
}

class MessagesError extends MessageScreenState {
  final String error;

  const MessagesError(this.error);
  @override
  List<Object> get props => [error];
}

class MessageSent extends MessageScreenState {}

class SendingMessageError extends MessageScreenState {
  final String error;

  const SendingMessageError(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
