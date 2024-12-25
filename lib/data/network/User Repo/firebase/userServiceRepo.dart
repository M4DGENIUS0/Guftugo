import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Domain/model/model.dart';

abstract class UserRepository {
  // Check Asynwise if the user is login or not
  Stream<User?> get user;

  // Login as registered user
  Future<void> Login(String email, String password);

  // Sign up as new user
  Future<UserModel> SignUp(UserModel userData, String Password);
  // Future<String> SignUp(String name, String email, String Password);

  // Log Out
  Future LogOut(BuildContext context);

  // Reset your Registered account by using email
  Future<void> Resetpassword(
    String email,
  );

  // Insert User credientials like, name, image, bio etc;
  Future<void> setUserData(UserModel userData);

  //Fetch Userdata from Firebase
  Future<UserModel> getUserdata(String UserUID);
  // Fetch all available users
  Future<List<UserModel>> getAllUserDataExceptCurrent(String currentUserUID);
}
