import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Domain/model/model.dart';
import '../../data/network/User Repo/firebase/userServiceRepo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepo;

  SignupBloc({required UserRepository UserRepo})
      : userRepo = UserRepo,
        super(SignupInitial()) {
    on<EmailFieldEvent>(_emailField);
    on<PasswordFieldEvent>(_passwdField);
    on<PasswdUnhide>(_togglePasswd);
    on<ConfirmPasswdUnhide>(_toggleConfirmPasswd);
    on<SubmitEvent>(_SignUp);
  }
  void _emailField(EmailFieldEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwdField(PasswordFieldEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(passwd: event.passwd));
  }

  void _togglePasswd(PasswdUnhide event, Emitter<SignupState> emit) {
    emit(state.copyWith(unhide: !state.unhide));
  }

  void _toggleConfirmPasswd(
      ConfirmPasswdUnhide event, Emitter<SignupState> emit) {
    emit(state.copyWith(unhidee: !state.unhidee));
  }

  void _SignUp(SubmitEvent event, Emitter<SignupState> emit) async {
    emit(state.copyWith(load: true)); // Show loading
    try {
      UserModel user = await userRepo.SignUp(event.user, event.passwd);
      // await userRepo.SignUp(event.name, event.passwd, event.email);
      await userRepo.setUserData(user);
      emit(SignupSuccess());
    } on TimeoutException {
      emit(const SignupFailure(message: 'Request Time Out. Please retry.'));
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(message: 'Error: ${e.message}'));
    } catch (e) {
      emit(SignupFailure(message: e.toString()));
      print(e.toString());
    } finally {
      emit(state.copyWith(load: false));
    }
  }
}
