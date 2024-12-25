part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class getUserinfo extends UserEvent {
  final String userUID;
  const getUserinfo({required this.userUID});

  @override
  List<Object> get props => [userUID];
}
