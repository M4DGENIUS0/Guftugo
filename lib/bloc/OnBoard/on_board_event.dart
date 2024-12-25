part of 'on_board_bloc.dart';

sealed class OnBoardEvent extends Equatable {
  const OnBoardEvent();

  @override
  List<Object> get props => [];
}

class PageisChanged extends OnBoardEvent {
  final bool isChange;
  const PageisChanged({required this.isChange});
  @override
  // TODO: implement props
  List<Object> get props => [isChange];
}
