part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final int selectedSeat = 0;
}

class HomeSearchSeatEvent extends HomeEvent {
  final int selectedSeat;

  HomeSearchSeatEvent({required this.selectedSeat});
}
