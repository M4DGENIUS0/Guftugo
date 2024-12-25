import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guftago/utils/status/status.dart';

import '../../data/network/User Repo/firebase/userServiceRepo.dart';

part 'auth_state_event.dart';
part 'auth_state_state.dart';

class AuthStateBloc extends Bloc<AuthStateEvent, AuthStateState> {
  final UserRepository userRepo;
  late final StreamSubscription<User?> _streamSubscription;
  AuthStateBloc({required this.userRepo})
      : super(const AuthStateState.unknown()) {
    _streamSubscription = userRepo.user.listen(
      (event) {
        add(AuthUserChange(event));
      },
    );
    on<AuthUserChange>(_AuthUserChange);
  }

  void _AuthUserChange(AuthUserChange event, Emitter<AuthStateState> emit) {
    try {
      if (event.user != null) {
        emit(AuthStateState.Authenticate(event.user!));
      } else {
        emit(const AuthStateState.unAuthenticate());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
