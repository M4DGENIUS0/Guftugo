import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/network/User Repo/firebase/userServiceRepo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepo;
  LoginBloc({required this.userRepo}) : super(LoginInitial()) {
    on<EmailFieldEvent>(_emailField);
    on<PasswordFieldEvent>(_passwdField);
    on<PasswdUnhide>(_togglePasswd);
    on<SubmitEvent>(_Login);
    on<LogOut>(_LogOut);
    on<loading>(_load);
  }
  void _emailField(EmailFieldEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwdField(PasswordFieldEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwd: event.passwd));
  }

  void _togglePasswd(PasswdUnhide event, Emitter<LoginState> emit) {
    emit(state.copyWith(unhide: !state.unhide));
  }

  void _load(loading event, Emitter<LoginState> emit) {
    emit(state.copyWith(load: event.load));
  }

  void _Login(SubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(load: true)); // Show loading
    try {
      await userRepo.Login(event.email, event.passwd);
      emit(LoginSuccess());
    } on TimeoutException {
      emit(const LoginFailure(message: 'Request Time Out. Please retry.'));
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: 'Error: ${e.message}'));
    } catch (e) {
      emit(LoginFailure(message: 'Unexpected Error: ${e.toString()}'));
    } finally {
      emit(state.copyWith(load: false)); // Hide loading
    }
  }

  void _LogOut(LogOut event, Emitter<LoginState> emit) async {
    try {
      await userRepo.LogOut(event.context);
      emit(
          LoginInitial()); // Return to the initial login state after successful logout
    } catch (e) {
      emit(LoginFailure(message: 'Failed to log out: ${e.toString()}'));
    }
  }
}
