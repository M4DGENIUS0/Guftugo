import 'package:flutter/material.dart';
import 'package:guftago/Domain/model/model.dart';

import '../../../service/Chat Service/ChatroomService.dart';
import '../Messages/messages.dart';

class ChatViewModel {
  final ChatRoomService chatservice;
  final UserModel currentUser;
  final UserModel reciever;

  ChatViewModel(this.chatservice, this.currentUser, this.reciever) {
    getMessages();
  }
  String ChatRoomID = "";
  final _messageController = TextEditingController();
  TextEditingController get controller => _messageController;
  getMessages() {
    if (currentUser.id.hashCode > reciever.id.hashCode) {
      ChatRoomID = "${currentUser.id}_${reciever.id}";
    } else {
      ChatRoomID = "${reciever.id}_${currentUser.id}";
    }
  }
}
