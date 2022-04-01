// ignore_for_file: avoid_print

import 'dart:async';

import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
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
          add(UpdateCardDataEvent(userCards: cardsFromJson));
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

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
