import 'dart:async';

import 'package:banking/src/data/models/operation.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/operation.dart' as op;
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GraphQLRepositiry graphQLRepositiry;
  final SignInRegisterBloc signInRegisterBloc;
  StreamSubscription? streamSubscription;
  HistoryBloc({
    required this.graphQLRepositiry,
    required this.signInRegisterBloc,
  }) : super(HistoryEmptyState()) {
    on<FetchHistoryEvent>((event, emit) {
      try {
        Stream<QueryResult<dynamic>> stream = graphQLRepositiry
            .fetchHistory(FetchHistoryEvent(userId: event.userId));
        streamSubscription = stream.listen((event) async {
          List<OperationModel> operations = [];
          for (var operation in event.data!['user'][0]['histories']) {
            operations.add(OperationModel.fromJson(operation));
          }
          for (var operation in event.data!['user'][0]['historiesByUserIdTo']) {
            operations.add(OperationModel.fromJson(operation));
          }
          add(UpdateDataHistoryEvent(operations: operations));
        });
      } catch (e) {
        //
      }
    });
    on<UpdateDataHistoryEvent>((event, emit) {
      emit(HistoryLoadingState());
      emit(HistoryLoadedState(event.operations));
    });
    on<AddHistoryEvent>((event, emit) {});
    on<UpdateHistoryEvent>((event, emit) {});
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
