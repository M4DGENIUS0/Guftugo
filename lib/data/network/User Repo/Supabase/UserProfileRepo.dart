import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserProfile {
  Future<String?> uploadImagetoSupaBase(BuildContext context, XFile? image);
  Future<String?> updateImagetoSupaBase(BuildContext context, XFile? image);
  Future<bool> deleteImagefromSupaBase(BuildContext context);
  Stream<String?> fetchImageUrl(String file);
}
