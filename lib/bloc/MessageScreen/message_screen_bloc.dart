import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Domain/model/Messages/messages.dart';
import '../../Domain/model/model.dart';
import '../../service/Chat Service/ChatroomService.dart';

part 'message_screen_event.dart';
part 'message_screen_state.dart';

class MessageScreenBloc extends Bloc<MessageScreenEvent, MessageScreenState> {
  final ChatRoomService _chatService;

  MessageScreenBloc(
    this._chatService,
  ) : super(MessageScreenInitial()) {
    on<GetMessages>(_onFetchMessages);

    on<SendMessage>(_SendMessage);

    on<ClearInputEvent>(_onClearInput);
  }

  Stream<void> _SendMessage(
      SendMessage event, Emitter<MessageScreenState> emit) async* {
    emit(MessagesLoading()); // Consider showing loading state while sending
    try {
      final now = DateTime.now();

      final message = Message(
        id: now.millisecondsSinceEpoch.toString(),
        content: event.content,
        senderId: event.sender.id,
        receiverId: event.receiver.id,
        timestamp: event.time,
      );
      await _chatService.saveMessages(message.toMap(), event.chatRoomID);
      emit(MessageSent());
    } catch (e) {
      emit(SendingMessageError(e.toString()));
    }
  }

  void _onClearInput(ClearInputEvent event, Emitter<MessageScreenState> emit) {
    emit(MessageScreenInitial());
  }

  void _onFetchMessages(
      GetMessages event, Emitter<MessageScreenState> emit) async {
    emit(MessagesLoading()); // Emit loading state

    try {
      final messageStream = _chatService.getMessages(event.chatroomId);

      // Use emit.forEach to handle the stream
      await emit.forEach(
        messageStream, // Stream of snapshots
        onData: (snapshot) {
          print("Received snapshot: ${snapshot.docs.length} messages");
          // final Datetime = snapshot..map((time){
          //   try {
          //     return Message.fromMap(time.data());
          //   } catch (e) {

          //   }
          // });
          // Parse messages from snapshot
          final messages = snapshot.docs
              .map((doc) {
                try {
                  return Message.fromMap(doc.data());
                } catch (e) {
                  print("Error parsing message: $e");
                  return null; // Skip invalid messages
                }
              })
              .whereType<Message>()
              .toList(); // Filter null values

          return MessagesLoaded(messages); // Emit MessagesLoaded state
        },
        onError: (error, stackTrace) {
          print("Stream error: $error");
          return MessagesError(error.toString()); // Emit MessagesError state
        },
      );
    } catch (e) {
      // Handle other exceptions
      print("Error fetching messages: $e");
      emit(MessagesError(e.toString()));
    }
  }
}
