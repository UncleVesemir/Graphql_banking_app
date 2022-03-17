part of 'cards_bloc.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class AddCardEvent extends CardsEvent {
  final Card card;

  const AddCardEvent({required this.card});
}

class FetchCardsEvent extends CardsEvent {}

class EditCardEvent extends CardsEvent {}

class RemoveCardEvent extends CardsEvent {}
