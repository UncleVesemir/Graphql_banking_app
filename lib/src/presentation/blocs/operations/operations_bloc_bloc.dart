import 'dart:async';

import 'package:banking/src/data/models/operation.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/operation.dart' as op;
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/history/history_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
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
  final HistoryBloc historyBloc;
  StreamSubscription? streamSubscription;
  OperationsBloc({
    required this.historyBloc,
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
              if (operation.status == 'sended') {
                var value =
                    (double.parse(cardsState.cards.first.cardInfo.value) -
                            double.parse(operation.value))
                        .toString();
                int cardId = operation.cardFrom;
                cardsBloc.add(
                  UpdateCardValueEvent(
                    cardId: cardId,
                    value: value,
                    operation: UpdateOperationStatusEvent(
                      operationId: operation.id!,
                      status: 'sended',
                    ),
                  ),
                );
                graphQLRepositiry.addHistory(
                  AddHistoryEvent(
                    operation: op.Operation(
                      value: operation.value,
                      text: operation.text,
                      userFrom: operation.userFrom,
                      userTo: operation.userTo,
                      cardFrom: operation.cardFrom,
                      cardTo: operation.cardTo,
                      time: operation.time,
                      status: 'not confirmed',
                    ),
                  ),
                );
              }
            }
          } else {
            if (cardsState is CardsLoadedState) {
              if (operation.status == 'not confirmed') {
                var value =
                    (double.parse(cardsState.cards.first.cardInfo.value) +
                            double.parse(operation.value))
                        .toString();
                int cardId = operation.cardTo;
                var historyState = historyBloc.state as HistoryLoadedState;
                // var transactionIndex = historyState.operations
                //     .indexWhere((element) => element.time == operation.time);
                // graphQLRepositiry.updateHistory(
                //   UpdateHistoryEvent(
                //     status: 'confirmed',
                //     transactionId:
                //         historyState.operations[transactionIndex].id!,
                //   ),
                // );
                cardsBloc.add(
                  UpdateCardValueEvent(
                    cardId: cardId,
                    value: value,
                    operation: UpdateOperationStatusEvent(
                      operationId: operation.id!,
                      status: 'not confirmed',
                    ),
                  ),
                );
              }
            }
          }
        }
      }
      emit(OperationsLoadedState(operations: event.operations));
      print('operations updated');
    });
    on<UpdateOperationStatusEvent>((event, emit) {});
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
