import '../../../../../Domain/model/model.dart';

abstract class UserListAbstract {
  // Fetch User Crediential in Real-time
  Stream<List<UserModel>> getAllUserDataExceptCurrent(String currentUserUID);
}
