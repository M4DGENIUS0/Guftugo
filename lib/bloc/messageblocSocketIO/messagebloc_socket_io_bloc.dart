import 'package:bloc/bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../Domain/model/model.dart';

part 'messagebloc_socket_io_event.dart';
part 'messagebloc_socket_io_state.dart';

class MessageblocSocketIoBloc
    extends Bloc<MessageblocSocketIoEvent, MessageblocSocketIoState> {
  late IO.Socket socket;
  final List<MessageModel> _messages = [];

  MessageblocSocketIoBloc() : super(ChatInitial()) {
    on<ConnectToSocketEvent>((event, emit) async {
      _connectToSocket(event.sourceId);
      emit(ChatConnecting());
    });

    on<SendMessageEvent>((event, emit) {
      _sendMessage(event.message, event.sourceId, event.targetId);
    });

    on<ReceiveMessageEvent>((event, emit) {
      _messages.add(event.messageModel);
      emit(ChatMessageReceived(messages: List.from(_messages)));
    });
  }

  void _connectToSocket(String sourceId) {
    // Ensure any existing socket is disconnected before creating a new one
    if (socket.connected) {
      socket.disconnect();
      socket.dispose();
    }

    socket = IO.io("https://chat-app-service.up.railway.app", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    socket.onConnect((_) {
      socket.emit("signin", sourceId);
      add(ReceiveMessageEvent(
          messageModel: MessageModel(
              message: "Connected",
              type: "info",
              time: DateTime.now().toString())));
    });

    socket.on("message", (data) {
      final receivedMessage = MessageModel(
        message: data["message"],
        type: data["sourceId"] == sourceId ? "source" : "destination",
        time: DateTime.now().toString(),
      );
      add(ReceiveMessageEvent(messageModel: receivedMessage));
    });

    socket.onDisconnect((_) {
      add(ReceiveMessageEvent(
          messageModel: MessageModel(
              message: "Disconnected",
              type: "info",
              time: DateTime.now().toString())));
    });
  }

  void _sendMessage(String message, String sourceId, String targetId) {
    if (socket.connected) {
      socket.emit("message",
          {"message": message, "sourceId": sourceId, "targetId": targetId});
      add(ReceiveMessageEvent(
          messageModel: MessageModel(
              message: message,
              type: "source",
              time: DateTime.now().toString())));
    }
  }

  @override
  Future<void> close() {
    socket.disconnect();
    socket.dispose();
    return super.close();
  }
}
