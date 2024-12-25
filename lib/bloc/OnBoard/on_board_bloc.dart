import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_board_event.dart';
part 'on_board_state.dart';

class OnBoardBloc extends Bloc<OnBoardEvent, OnBoardState> {
  OnBoardBloc() : super(OnBoardInitial()) {
    on<PageisChanged>(_PageisChanged);
  }

  void _PageisChanged(PageisChanged event, Emitter<OnBoardState> emit) {
    emit(state.copyWith(isChange: event.isChange));
  }
}
