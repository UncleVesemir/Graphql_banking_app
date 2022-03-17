part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

class CardsEmptyState extends CardsState {}

class CardsLoadingState extends CardsState {}

class CardsLoadedState extends CardsState {}

class CardsErrorState extends CardsState {}
