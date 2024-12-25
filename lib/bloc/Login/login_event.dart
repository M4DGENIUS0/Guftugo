part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailFieldEvent extends LoginEvent {
  final String email;
  const EmailFieldEvent({this.email = ''});
  @override
  List<Object> get props => [email];
}

class PasswordFieldEvent extends LoginEvent {
  final String passwd;
  const PasswordFieldEvent({this.passwd = ''});
  @override
  List<Object> get props => [passwd];
}

class PasswdUnhide extends LoginEvent {}

class SubmitEvent extends LoginEvent {
  final String email;
  final String passwd;
  const SubmitEvent({required this.email, required this.passwd});

  @override
  List<Object> get props => [email, passwd];
}

class LogOut extends LoginEvent {
  final BuildContext context;
  const LogOut(this.context);
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class loading extends LoginEvent {
  bool load;
  loading({required this.load});

  @override
  // TODO: implement props
  List<Object> get props => [load];
}
