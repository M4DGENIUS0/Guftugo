part of 'on_board_bloc.dart';

class OnBoardState extends Equatable {
  bool isChange;
  OnBoardState({this.isChange = false});

  OnBoardState copyWith({bool? isChange}) {
    return OnBoardState(isChange: isChange ?? this.isChange);
  }

  @override
  List<Object> get props => [isChange];
}

final class OnBoardInitial extends OnBoardState {}
