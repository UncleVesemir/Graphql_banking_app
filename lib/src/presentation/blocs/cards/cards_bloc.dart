import 'dart:async';

import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/card.dart';
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
    streamSubscription = signInRegisterBloc.stream.listen((state) {});
    streamSubscription!.onData((state) {
      if (state is SignInRegisterLoadedState) {
        add(FetchCardsEvent(userId: state.user.id));
      }
    });
    on<AddCardEvent>((event, emit) async {
      emit(CardsLoadingState());
      try {
        await graphQLRepositiry.addCard(event);
      } catch (e) {
        print(e);
      }
    });
    on<UpdatedDataEvent>((event, emit) async {
      emit(CardsLoadingState());
      emit(CardsLoadedState(card: event.userCards));
      print('cards updated');
    });
    on<FetchCardsEvent>((event, emit) async {
      emit(CardsLoadingState());
      try {
        Stream<QueryResult<dynamic>> stream =
            graphQLRepositiry.fetchCards(FetchCardsEvent(userId: event.userId));
        streamSubscription = stream.listen((event) async {
          List<Card> cards = [];
          for (var i = 0; i < event.data!['card'].length; i++) {
            cards.add(CardModel.fromJson(event.data!['card'][i]));
          }
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
                  width: 280,
                  height: 180,
                  gradient: AppColors.appBackgroundGradient,
                ),
              ),
            );
            i++;
          }
          add(UpdatedDataEvent(userCards: _cards));
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
