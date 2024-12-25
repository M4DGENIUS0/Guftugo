import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomService {
  final _firestore = FirebaseFirestore.instance;

  saveMessages(
      // BuildContext context,
      Map<String, dynamic> message,
      String ChatRoomID) async {
    try {
      await _firestore
          .collection("ChatBoxs")
          .doc(ChatRoomID)
          .collection("communication")
          .add(message);
    } catch (e) {
      // showCustomToast(context, "Error: $e");
      rethrow;
    }
  }

  // Fetch Messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String ChatRoomID) {
    return _firestore
        .collection("ChatBoxs")
        .doc(ChatRoomID)
        .collection("communication")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
