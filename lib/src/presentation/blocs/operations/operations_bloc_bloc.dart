import 'dart:async';

import 'package:banking/src/data/models/operation.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/operation.dart' as op;
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'operations_bloc_event.dart';
part 'operations_bloc_state.dart';

class OperationsBloc extends Bloc<OperationsBlocEvent, OperationsBlocState> {
  final GraphQLRepositiry graphQLRepositiry;
  final CardsBloc cardsBloc;
  final SignInRegisterBloc signInRegisterBloc;
  StreamSubscription? streamSubscription;
  OperationsBloc({
    required this.signInRegisterBloc,
    required this.cardsBloc,
    required this.graphQLRepositiry,
  }) : super(OperationsEmptyState()) {
    on<UpdateOperationsDataEvent>((event, emit) {
      emit(OperationsLoadingState());
      for (var operation in event.operations) {
        var userState = signInRegisterBloc.state;
        var cardsState = cardsBloc.state;
        if (userState is SignInRegisterLoadedState) {
          if (operation.userFrom == userState.user.id) {
            if (cardsState is CardsLoadedState) {
              var value = (double.parse(cardsState.cards.first.cardInfo.value) -
                      double.parse(operation.value))
                  .toString();
              int cardId = operation.cardFrom;
              cardsBloc.add(UpdateCardValueEvent(cardId: cardId, value: value));
            }
          } else {
            if (cardsState is CardsLoadedState) {
              var value = (double.parse(cardsState.cards.first.cardInfo.value) +
                      double.parse(operation.value))
                  .toString();
              int cardId = operation.cardTo;
              cardsBloc.add(UpdateCardValueEvent(cardId: cardId, value: value));
            }
          }
        }
      }
      emit(OperationsLoadedState(operations: event.operations));
      print('operations updated');
    });
    on<FetchOperationsEvent>((event, emit) async {
      emit(OperationsLoadingState());
      Stream<QueryResult<dynamic>> stream =
          graphQLRepositiry.fetchOperations(event);
      streamSubscription = stream.listen((event) async {
        List<op.Operation> operations = [];
        for (var operation in event.data!['user'][0]['operations']) {
          operations.add(OperationModel.fromJson(operation));
        }
        for (var operation in event.data!['user'][0]['operationsByUserIdTo']) {
          operations.add(OperationModel.fromJson(operation));
        }
        add(UpdateOperationsDataEvent(operations: operations));
      });
    });
    on<AddOperationEvent>((event, emit) async {
      try {
        bool isSuccesfull = await graphQLRepositiry.addOperation(event);
        if (isSuccesfull) {
          print('Succes');
        } else {
          print('Error');
        }
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
