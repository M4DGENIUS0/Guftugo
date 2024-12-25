part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class NameFieldEvent extends SignupEvent {
  final String name;
  const NameFieldEvent({this.name = ''});
  @override
  List<Object> get props => [name];
}

class EmailFieldEvent extends SignupEvent {
  final String email;
  const EmailFieldEvent({this.email = ''});
  @override
  List<Object> get props => [email];
}

class PasswordFieldEvent extends SignupEvent {
  final String passwd;
  const PasswordFieldEvent({this.passwd = ''});
  @override
  List<Object> get props => [passwd];
}

class PasswdUnhide extends SignupEvent {}

class ConfirmPasswdUnhide extends SignupEvent {}

class SubmitEvent extends SignupEvent {
  final UserModel user;

  final String passwd;

  const SubmitEvent(this.user, this.passwd);

  @override
  List<Object> get props => [user, passwd];
}

class loading extends SignupEvent {}
