part of 'real_time_chat_user_list_bloc.dart';

sealed class RealTimeChatUserListState extends Equatable {
  const RealTimeChatUserListState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends RealTimeChatUserListState {}

class EmptyUsers extends RealTimeChatUserListState {
  final String message;
  const EmptyUsers({this.message = ""});
  @override
  List<Object> get props => [message];
}

class UsersLoading extends RealTimeChatUserListState {}

class UsersLoaded extends RealTimeChatUserListState {
  final List<UserModel> users;
  final List<Map<String, dynamic>> usersProfile;
  const UsersLoaded({this.users = const [], this.usersProfile = const []});
  @override
  List<Object> get props => [users, usersProfile];
}

class UsersError extends RealTimeChatUserListState {
  final String message;
  const UsersError(this.message);
  @override
  List<Object> get props => [message];
}
