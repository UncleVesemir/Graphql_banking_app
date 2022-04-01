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

class FetchCardsEvent extends CardsEvent {
  final int userId;
  const FetchCardsEvent({required this.userId});
}

class UpdateCardValueEvent extends CardsEvent {
  final int cardId;
  final String value;
  final UpdateOperationStatusEvent operation;
  const UpdateCardValueEvent({
    required this.cardId,
    required this.value,
    required this.operation,
  });
}

class UpdateCardDataEvent extends CardsEvent {
  final List<Card> userCards;
  const UpdateCardDataEvent({required this.userCards});
}

class EditCardEvent extends CardsEvent {}

class RemoveCardEvent extends CardsEvent {}
