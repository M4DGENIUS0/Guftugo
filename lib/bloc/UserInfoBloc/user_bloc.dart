import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guftago/utils/status/status.dart';

import '../../Domain/model/User model/model.dart';
import '../../data/network/User Repo/firebase/userServiceRepo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepo;
  UserBloc({required UserRepository UserRepository})
      : _userRepo = UserRepository,
        super(const UserState.loading()) {
    on<getUserinfo>((event, emit) async {
      UserModel user = await _userRepo.getUserdata(event.userUID);
      try {
        emit(UserState.success(user));
      } catch (e) {
        emit(const UserState.failure());
      }
    });
  }
}
