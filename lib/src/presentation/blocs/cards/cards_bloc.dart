import 'dart:async';

import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/card.dart';
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
    // streamSubscription = signInRegisterBloc.stream.listen((state) {});
    // streamSubscription!.onData((state) {
    // if (state is SignInRegisterLoadedState) {
    //   add(FetchCardsEvent(userId: state.user.id));
    // }
    // });
    // on<AddCardEvent>((event, emit) async {
    //   emit(CardsLoadingState());
    //   try {
    //     final Card card = await graphQLRepositiry.addCard(event);
    //     emit(CardsLoadedState(card: card));
    //   } catch (e) {
    //     print(e);
    //     emit(CardsErrorState(error: e));
    //   }
    // });
    on<UpdatedDataEvent>((event, emit) async {
      emit(CardsLoadedState(card: event.userCards));
    });
    on<FetchCardsEvent>((event, emit) async {
      emit(CardsLoadingState());
      try {
        print('data');
        Stream<QueryResult<dynamic>> stream =
            graphQLRepositiry.fetchCards(FetchCardsEvent(userId: event.userId));
        streamSubscription = stream.listen((event) {});
        var len;
        streamSubscription!.onData((event) {
          print(event.data);
          print(event.data!['card'].length);
          List<Card> cards = [];
          for (var i = 0; i < event.data!['card'].length; i++) {
            cards.add(CardModel.fromJson(event.data!['card'][i]));
            print(CardModel.fromJson(event.data!['card'][i]).expDate);
          }
          add(UpdatedDataEvent(userCards: cards));
        });
        // stream.listen((event) async {});
      } catch (e) {
        print(e);
      }
    });
  }

  // @override
  // Future<void> close() {
  //   streamSubscription?.cancel();
  //   return super.close();
  // }
}
