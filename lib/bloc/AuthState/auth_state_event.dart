part of 'auth_state_bloc.dart';

abstract class AuthStateEvent extends Equatable {
  const AuthStateEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChange extends AuthStateEvent {
  final User? user;
  const AuthUserChange(this.user);
}
