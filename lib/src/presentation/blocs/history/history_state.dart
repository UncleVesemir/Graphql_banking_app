part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryEmptyState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<OperationModel> operations;
  const HistoryLoadedState(this.operations);
}

class HistoryLoadingState extends HistoryState {}

class HistoryErrorState extends HistoryState {}
