import 'dart:async';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../Domain/entities/entities.dart';
import '../../../../Domain/model/model.dart';
import '../../../../config/routes/route_name.dart';
import 'userServiceRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  // Make User collection in Firestore database
  final userCollection = FirebaseFirestore.instance.collection('users');

  // Check weather user is authenticated or not
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(
      (firebaseEvent) {
        final user = firebaseEvent;
        return user;
      },
    );
  }

  // Sign Up User Firebase
  @override
  Future<UserModel> SignUp(UserModel userData, String Password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userData.email, password: Password);
      userData = userData.copyWith(id: user.user!.uid);
      return userData;
    } catch (e) {
      print(e);
      throw (e.toString());
    }
  }
  // Login User Firebase

  @override
  Future<void> Login(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw ('Request Timeout, Retry Again');
    }
  }

  // Reset Password if forgotten
  @override
  Future<void> Resetpassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.toString();
    }
  }

  // Log out User Firebase
  @override
  Future LogOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut().then(
        (value) {
          Navigator.pushNamedAndRemoveUntil(
              context, Route_Name.AuthScreen, (route) => false);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  // Insert user crediential in firestore database
  @override
  Future<void> setUserData(UserModel userData) async {
    try {
      await userCollection
          .doc(userData.id)
          .set(userData.toEntity().toDocument());
    } catch (e) {
      throw e.toString();
    }
  }

  // fetch user crediential in firestore database
  @override
  Future<UserModel> getUserdata(String UserUID) async {
    try {
      return userCollection.doc(UserUID).get().then(
            (value) =>
                UserModel.fromEntity(UserEntities.fromDocument(value.data()!)),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch all available users from firestore database
  @override
  Future<List<UserModel>> getAllUserDataExceptCurrent(
      String currentUserUID) async {
    try {
      // Get all documents from the user collection
      var querySnapshot = await userCollection.get();

      // Filter out the current user using their UID
      var userDocs = querySnapshot.docs
          .where((doc) => doc.id != currentUserUID) // Exclude the current user
          .map((doc) =>
              UserModel.fromEntity(UserEntities.fromDocument(doc.data())))
          .toList();

      return userDocs;
    } catch (e) {
      throw e.toString();
    }
  }
}
