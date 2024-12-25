abstract class UserListProfileAbstract {
  // Fetch User Profile Picture in Real-time
  Stream<List<Map<String, dynamic>>> getAllUsersWithProfilesExceptCurrent(
      String currentUserUID);
}
