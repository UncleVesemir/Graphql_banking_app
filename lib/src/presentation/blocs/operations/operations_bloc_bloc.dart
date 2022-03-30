import 'dart:async';

import 'package:banking/src/data/models/operation.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/operation.dart' as op;
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/history/history_bloc.dart';
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
  final HistoryBloc historyBloc;
  StreamSubscription? streamSubscription;
  OperationsBloc({
    required this.historyBloc,
    required this.signInRegisterBloc,
    required this.cardsBloc,
    required this.graphQLRepositiry,
  }) : super(OperationsEmptyState()) {
    on<UpdateOperationsDataEvent>((event, emit) async {
      emit(OperationsLoadingState());
      for (var operation in event.operations) {
        var userState = signInRegisterBloc.state;
        if (userState is SignInRegisterLoadedState) {
          if (operation.userFrom == userState.user.id) {
            if (operation.status == 'sended') {
              if (_getCardTo(operation, true) != null) {
                var card = _getCardTo(operation, true);
                var value = (double.parse(card!.cardInfo.value) -
                        double.parse(operation.value))
                    .toString();
                _updateCardValue(
                    operation, card.cardInfo.cardId, value, 'sended');
                _addToHistory(operation);
              }
            }
          } else if (operation.userFrom != userState.user.id) {
            if (operation.status == 'not confirmed') {
              if (_getCardTo(operation, false) != null) {
                var card = _getCardTo(operation, false);
                var value = (double.parse(card!.cardInfo.value) +
                        double.parse(operation.value))
                    .toString();
                _updateCardValue(
                    operation, card.cardInfo.cardId, value, 'not confirmed');
                if (historyBloc.state is HistoryLoadedState) {
                  _updateHistory(
                      historyBloc.state as HistoryLoadedState, operation);
                }
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
        add(UpdateOperationsDataEvent(operations: _convertFromJson(event)));
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

  void _updateHistory(HistoryLoadedState state, op.Operation operation) {
    var transactionIndex = state.operations
        .indexWhere((element) => element.uuid == operation.uuid);
    graphQLRepositiry.updateHistory(
      UpdateHistoryEvent(
        status: 'confirmed',
        transactionId: state.operations[transactionIndex].id!,
      ),
    );
  }

  CreditCardItem? _getCardTo(op.Operation operation, bool isSended) {
    var state = cardsBloc.state;
    CreditCardItem card;
    if (state is CardsLoadedState) {
      var cardIdTo = isSended ? operation.cardFrom : operation.cardTo;
      card = state.cards
          .firstWhere((element) => element.cardInfo.cardId == cardIdTo);
      return card;
    }
    return null;
  }

  List<op.Operation> _convertFromJson(QueryResult<dynamic> event) {
    List<op.Operation> operations = [];
    for (var operation in event.data!['user'][0]['operations']) {
      operations.add(OperationModel.fromJson(operation));
    }
    for (var operation in event.data!['user'][0]['operationsByUserIdTo']) {
      operations.add(OperationModel.fromJson(operation));
    }
    return operations;
  }

  void _updateCardValue(
      op.Operation operation, int cardId, String value, String status) async {
    cardsBloc.add(
      UpdateCardValueEvent(
        cardId: cardId,
        value: value,
        operation: UpdateOperationStatusEvent(
          operationId: operation.id!,
          status: status,
        ),
      ),
    );
  }

  void _addToHistory(op.Operation operation) {
    graphQLRepositiry.addHistory(
      AddHistoryEvent(
        operation: op.Operation(
          uuid: operation.uuid,
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

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
