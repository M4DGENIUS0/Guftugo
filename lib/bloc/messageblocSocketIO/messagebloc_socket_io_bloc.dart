import 'package:bloc/bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../Domain/model/Messages/chatMessageModelSocketio.dart';

part 'messagebloc_socket_io_event.dart';
part 'messagebloc_socket_io_state.dart';

class MessageblocSocketIoBloc
    extends Bloc<MessageblocSocketIoEvent, MessageblocSocketIoState> {
  IO.Socket? socket; // Make the socket nullable
  final List<MessageModel> _messages = [];

  MessageblocSocketIoBloc() : super(ChatInitial()) {
    on<ConnectToSocketEvent>(_onConnectToSocketEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<ReceiveMessageEvent>(_onReceiveMessageEvent);
  }

  // Stream-based connection logic
  Stream<void> _connectToSocket(String sourceId) async* {
    // Ensure the socket is clean before reconnecting
    if (socket?.connected ?? false) {
      socket?.disconnect();
      socket?.dispose();
    }

    // Initialize socket if it's not already initialized
    socket ??=
        IO.io("https://chat-app-service.up.railway.app", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket?.connect();

    // When connected
    socket?.onConnect((_) {
      socket?.emit("signin", sourceId);
      add(ReceiveMessageEvent(
        messageModel: MessageModel(
          message: "Connected",
          type: "info",
          time: DateTime.now().toString(),
        ),
      ));
    });

    // Handle received messages
    socket?.on("message", (data) {
      final receivedMessage = MessageModel(
        message: data["message"],
        type: data["sourceId"] == sourceId ? "source" : "destination",
        time: DateTime.now().toString(),
      );
      add(ReceiveMessageEvent(messageModel: receivedMessage));
    });

    // When disconnected
    socket?.onDisconnect((_) {
      add(ReceiveMessageEvent(
        messageModel: MessageModel(
          message: "Disconnected",
          type: "info",
          time: DateTime.now().toString(),
        ),
      ));
    });
  }

  Future<void> _onConnectToSocketEvent(ConnectToSocketEvent event,
      Emitter<MessageblocSocketIoState> emit) async {
    emit(ChatConnecting());
    await for (var _ in _connectToSocket(event.sourceId)) {
      // No explicit actions needed here, as Stream will trigger necessary events.
    }
  }

  void _onSendMessageEvent(
      SendMessageEvent event, Emitter<MessageblocSocketIoState> emit) {
    if (socket?.connected ?? false) {
      socket?.emit("message", {
        "message": event.message,
        "sourceId": event.sourceId,
        "targetId": event.targetId,
      });
      add(ReceiveMessageEvent(
        messageModel: MessageModel(
          message: event.message,
          type: "source",
          time: DateTime.now().toString(),
        ),
      ));
    }
  }

  void _onReceiveMessageEvent(
      ReceiveMessageEvent event, Emitter<MessageblocSocketIoState> emit) {
    _messages.add(event.messageModel);
    emit(ChatMessageReceived(messages: List.from(_messages)));
  }

  @override
  Future<void> close() async {
    if (socket?.connected ?? false) {
      socket?.disconnect();
      socket?.dispose();
    }
    return super.close();
  }
}
