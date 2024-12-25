part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String name;
  final String email;
  final String passwd;
  final bool unhidee;
  final bool unhide;
  final bool load;

  const SignupState(
      {this.name = '',
      this.email = '',
      this.passwd = '',
      this.unhide = true,
      this.unhidee = true,
      this.load = false});

  SignupState copyWith(
      {String? name,
      String? email,
      String? passwd,
      bool? unhide,
      bool? unhidee,
      bool? load}) {
    return SignupState(
        name: name ?? this.name,
        email: email ?? this.email,
        passwd: passwd ?? this.passwd,
        unhide: unhide ?? this.unhide,
        unhidee: unhidee ?? this.unhidee,
        load: load ?? this.load);
  }

  @override
  List<Object> get props => [email, passwd, unhide, name, unhidee, load];
}

final class SignupInitial extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailure extends SignupState {
  final String message;
  const SignupFailure({this.message = ''});

  @override
  List<Object> get props => [message];
}

final class SignupProcess extends SignupState {}
