part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String passwd;
  final bool unhide;
  final bool load;
  const LoginState(
      {this.email = '',
      this.passwd = '',
      this.unhide = true,
      this.load = false});

  LoginState copyWith(
      {String? email, String? passwd, bool? unhide, bool? load}) {
    return LoginState(
        email: email ?? this.email,
        passwd: passwd ?? this.passwd,
        unhide: unhide ?? this.unhide,
        load: load ?? this.load);
  }

  @override
  List<Object> get props => [email, passwd, unhide, load];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure({this.message = ''});

  @override
  List<Object> get props => [message];
}

class LoginProcess extends LoginState {}
