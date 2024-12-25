import 'package:flutter/material.dart';

import '../Storage/local_storage.dart';

class SessionController {
  final LocalStorage sharedPreferenceClass = LocalStorage();

  static final SessionController _session = SessionController._internal();

  static bool? isLogin;

  SessionController._internal() {
    isLogin = false;
  }

  //In Dart, a factory constructor is a special kind of constructor that can return an instance of the class,
  // potentially a cached or pre-existing instance, instead of always creating a new one.
  // It's defined using the factory keyword.
  // This is useful for implementing patterns like singletons or when you want to control instance creat
  //
  /// Factory constructor for accessing the singleton instance of [SessionController].
  factory SessionController() {
    return _session;
  }

  /// Saves user data into the local storage.
  ///
  /// Takes a [user] object as input and saves it into the local storage.
  Future<void> saveUserInPreference() async {
    // Storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  /// Retrieves user data from the local storage and assigns it to the session controller
  /// to be used across the app.
  Future<void> getUserFromPreference() async {
    try {
      var isLogin = await sharedPreferenceClass.readValue('isLogin');
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
