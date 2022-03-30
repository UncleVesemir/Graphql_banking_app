import 'dart:async';

import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/operation.dart' as op;
import 'package:banking/src/presentation/blocs/history/history_bloc.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final GraphQLRepositiry graphQLRepositiry;
  final SignInRegisterBloc signInRegisterBloc;
  StreamSubscription? streamSubscription;
  CardsBloc({
    required this.graphQLRepositiry,
    required this.signInRegisterBloc,
  }) : super(CardsEmptyState()) {
    streamSubscription = signInRegisterBloc.stream.listen((state) async {
      if (state is SignInRegisterLoadedState) {
        add(FetchCardsEvent(userId: state.user.id));
      }
    });

    on<AddCardEvent>((event, emit) async {
      try {
        emit(CardsLoadingState());
        await graphQLRepositiry.addCard(event);
      } catch (e) {
        print(e);
      }
    });

    on<UpdateCardDataEvent>((event, emit) async {
      emit(CardsLoadingState());
      print("HERE");
      emit(CardsLoadedState(cards: event.userCards));
      print('cards updated');
    });

    /// FROM OPERATIONS BLOC WHEN OPERATION ADDED
    on<UpdateCardValueEvent>((event, emit) async {
      emit(CardsLoadingState());
      try {
        bool isSuccesful = await graphQLRepositiry.updateCardValue(event);
        if (isSuccesful) {
          if (event.operation.status == 'sended') {
            print(event.value);
            graphQLRepositiry.updateCardValue(event).then((bool isUpdated) {
              if (isUpdated) {
                graphQLRepositiry.updateStatus(event.operation);
              }
            });
          } else if (event.operation.status == 'not confirmed') {
            print(event.value);
            graphQLRepositiry.updateCardValue(event).then((bool isUpdated) {
              if (isUpdated) {
                graphQLRepositiry.deleteOperation(event.operation.operationId);
              }
            });
          }
        }
      } catch (e) {
        print(e);
      }
    });

    ///

    on<FetchCardsEvent>((event, emit) async {
      emit(CardsLoadingState());
      try {
        Stream<QueryResult<dynamic>> stream =
            graphQLRepositiry.fetchCards(FetchCardsEvent(userId: event.userId));
        streamSubscription = stream.listen((event) async {
          List<Card> cardsFromJson = _convertFromJson(event);
          List<CreditCardItem> widgetsFromModel =
              _convertToWidgets(cardsFromJson);
          add(UpdateCardDataEvent(userCards: widgetsFromModel));
        });
      } catch (e) {
        print(e);
      }
    });
  }

  List<Card> _convertFromJson(QueryResult<dynamic> event) {
    List<Card> cards = [];
    for (var i = 0; i < event.data!['card'].length; i++) {
      cards.add(CardModel.fromJson(event.data!['card'][i]));
    }
    return cards;
  }

  List<CreditCardItem> _convertToWidgets(List<Card> cards) {
    List<CreditCardItem> _cards = [];
    int i = 0;
    for (var card in cards) {
      _cards.add(
        CreditCardItem(
          cardInfo: CreditCardModel(
            index: i,
            cardHolderName: card.name,
            cardNumber: card.number,
            expDate: card.expDate,
            value: card.value,
            width: 280,
            height: 180,
            cardId: card.id!,
            gradient: AppColors.appBackgroundGradient,
          ),
        ),
      );
      i++;
    }
    return _cards;
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
