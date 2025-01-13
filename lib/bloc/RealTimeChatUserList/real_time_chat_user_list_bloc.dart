import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Domain/model/User model/model.dart';
import '../../data/network/Chat Repo/UserList/Firebase/UserListAbstractRepo.dart';
import '../../data/network/Chat Repo/UserList/Supabase/UserListProfileRepo.dart';

part 'real_time_chat_user_list_event.dart';
part 'real_time_chat_user_list_state.dart';

class RealTimeChatUserListBloc
    extends Bloc<RealTimeChatUserListEvent, RealTimeChatUserListState> {
  final UserListRepo userRepository;
  final UserProfileListRepo userRepo;

  RealTimeChatUserListBloc(this.userRepository, this.userRepo)
      : super(UsersInitial()) {
    on<FetchUsersList>(_FetchUsersList);

    on<UsersUpdated>((event, emit) {
      emit(UsersLoaded(users: event.users));
    });
  }

  void _FetchUsersList(
      FetchUsersList event, Emitter<RealTimeChatUserListState> emit) async {
    emit(UsersLoading());
    try {
      await emit.forEach<List<UserModel>>(
        userRepository.getAllUserDataExceptCurrent(event.currentUserUID),
        onData: (users) {
          if (users.isNotEmpty) {
            return UsersLoaded(users: users);
          } else {
            return const EmptyUsers(message: "No User");
          }
        },
        onError: (error, _) => UsersError(error.toString()),
      );
      await emit.forEach<List<Map<String, dynamic>>>(
        userRepo.getAllUsersWithProfilesExceptCurrent(event.currentUserUID),
        onData: (users) {
          print("Profiles bloc: ${users.length}");
          return UsersLoaded(usersProfile: users);
        },
        onError: (error, _) => UsersError(error.toString()),
      );
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }
}
