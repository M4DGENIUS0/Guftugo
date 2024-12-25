part of 'real_time_chat_user_list_bloc.dart';

sealed class RealTimeChatUserListEvent extends Equatable {
  const RealTimeChatUserListEvent();

  @override
  List<Object> get props => [];
}

class FetchUsersList extends RealTimeChatUserListEvent {
  final String currentUserUID;
  const FetchUsersList(this.currentUserUID);
  @override
  List<Object> get props => [currentUserUID];
}

class UsersUpdated extends RealTimeChatUserListEvent {
  final List<UserModel> users;
  const UsersUpdated(this.users);
}
