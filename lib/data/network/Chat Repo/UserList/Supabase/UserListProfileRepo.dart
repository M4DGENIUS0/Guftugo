import 'package:supabase_flutter/supabase_flutter.dart';

import 'UserListProfileabstract.dart';

class UserProfileListRepo implements UserListProfileAbstract {
  final SupabaseClient _supabaseClient;

  UserProfileListRepo({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient {
    print("Supabase client initialized: $_supabaseClient");
  }

  @override
  Stream<List<Map<String, dynamic>>> getAllUsersWithProfilesExceptCurrent(
      String currentUserUID) {
    // Use the Supabase stream API to get real-time updates
    return _supabaseClient
        .from('user')
        .stream(primaryKey: ['id']).map((users) async {
      // Process users to exclude the current user and include profile image URLs
      final usersWithProfiles = await Future.wait(
        users.map((user) async {
          if (user['id'] != currentUserUID) {
            final profileImageUrl = await _getProfileImageUrl(user['id']);
            return {
              ...user,
              'profile_image_url': profileImageUrl ?? '',
            };
          }
          return null; // Exclude current user
        }).toList(),
      );

      return usersWithProfiles.where((user) => user != null).toList();
    }).asyncExpand((futureList) async* {
      final usersWithProfiles = await futureList;
      yield usersWithProfiles
          .where((user) => user != null)
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  // Helper method to get profile image URL from Supabase storage
  Future<String?> _getProfileImageUrl(String userID) async {
    try {
      // Full path in your storage bucket
      final filePath = '/upload/$userID/Profile';

      // Replace 'user' with your actual bucket name
      final response =
          _supabaseClient.storage.from('user').getPublicUrl(filePath);

      print('Generated URL for user $userID: $response'); // Debug log
      return response;
    } catch (e) {
      print('Error generating public URL for user $userID: $e');
      return null; // Return null if an error occurs
    }
  }
}
