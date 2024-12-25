import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guftago/Domain/entities/entities.dart';

import '../../../../../Domain/model/model.dart';
import 'UserListAbstract.dart';

class UserListRepo implements UserListAbstract {
  final CollectionReference userCollection;

  UserListRepo({required this.userCollection});

  // Fetch User Crediential in Real-time
  @override
  Stream<List<UserModel>> getAllUserDataExceptCurrent(String currentUserUID) {
    try {
      return userCollection.snapshots().map(
        (event) {
          return event.docs
              .where((user) => user.id != currentUserUID)
              .map((User) => UserModel.fromEntity(UserEntities.fromDocument(
                  User.data() as Map<String, dynamic>)))
              .toList();
        },
      );
    } catch (e) {
      print("Error: $e");
      return Stream.error(e);
    }
  }
}
