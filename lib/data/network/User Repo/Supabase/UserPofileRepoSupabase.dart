import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/components/toast.dart';
import 'UserProfileRepo.dart';

class SupbaseUserRepo implements UserProfile {
  final Supabase _supabase;

  SupbaseUserRepo({Supabase? supabase})
      : _supabase = supabase ?? Supabase.instance;

  final userID = FirebaseAuth.instance.currentUser!.uid;
  final fileName = 'Profile';
  @override

  // Upload to SupaBase
  Future<String?> uploadImagetoSupaBase(
      BuildContext context, XFile? image) async {
    if (image == null) {
      return null;
    }
    // Generate a unique file path
    final path = '/upload/$userID/$fileName';
    // upload image to supabase
    try {
      await _supabase.client.storage
          .from('user')
          .upload(path, File(image.path));
    } catch (e) {
      print('Upload failed: $e');
      showCustomToast(context, "Upload failed: $e");
    }
    return null;
  }

  // Update current image in Supabase
  @override
  Future<String?> updateImagetoSupaBase(
      BuildContext context, XFile? newImage) async {
    if (newImage == null) {
      return null;
    }
    final path = '/upload/$userID/$fileName';
    try {
      // Delete the old image if it exists
      await _supabase.client.storage.from('user').remove([path]);

      // Upload the new image
      return await uploadImagetoSupaBase(context, newImage);
    } catch (e) {
      print('Update failed: $e');
      showCustomToast(context, "Update failed: $e");
      return null;
    }
  }

  // Delete current image from Supbase
  @override
  Future<bool> deleteImagefromSupaBase(BuildContext context) async {
    final path = 'upload/$userID/$fileName';
    if (path.isEmpty) {
      return false;
    }

    try {
      await _supabase.client.storage
          .from('user')
          .remove([path]); // Remove requires a list of file paths
      return true;
    } catch (e) {
      print('Delete failed: $e');
      showCustomToast(context, "Delete failed: $e");
      return false;
    }
  }

  //display image from database
  // @override
  // Future<String?> fetchImageUrl() async {
  //   final String filePath = 'upload/$userID/$fileName';

  //   try {
  //     // Fetching the public URL of the file
  //     final response = _supabase.client.storage
  //         .from('User Pofile') // Replace with your bucket name
  //         .getPublicUrl(filePath);

  //     return response;
  //   } catch (e) {
  //     debugPrint("Error fetching image URL: $e");
  //     return null;
  //   }
  // }
  @override
  Stream<String?> fetchImageUrl(String file) async* {
    try {
      final filePath = 'upload/$userID/$file';

      // Fetch the public URL of the file
      final response = _supabase.client.storage
          .from('user') // Replace with your bucket name
          .getPublicUrl(filePath);
      yield response;
    } catch (e) {
      debugPrint("Error fetching image URL: $e");
      return;
    }
  }
}
