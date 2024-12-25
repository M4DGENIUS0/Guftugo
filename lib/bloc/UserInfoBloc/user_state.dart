part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel? user;
  final GetUserDataStatus userStatus;
  const UserState({this.user, this.userStatus = GetUserDataStatus.loading});

  // User data is loading
  const UserState.loading() : this();
  // USer data is loaded successfully
  const UserState.success(UserModel user)
      : this(user: user, userStatus: GetUserDataStatus.success);
  // failure occured while fetching user data
  const UserState.failure() : this(userStatus: GetUserDataStatus.failure);

  @override
  List<Object?> get props => [user, userStatus];
}
