part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchHistoryEvent extends HistoryEvent {
  final int userId;
  const FetchHistoryEvent({required this.userId});
}

class UpdateDataHistoryEvent extends HistoryEvent {
  final List<OperationModel> operations;
  const UpdateDataHistoryEvent({required this.operations});
}

class AddHistoryEvent extends HistoryEvent {
  final op.Operation operation;
  const AddHistoryEvent({required this.operation});
}

class UpdateHistoryEvent extends HistoryEvent {
  final int transactionId;
  final String status;
  const UpdateHistoryEvent({required this.transactionId, required this.status});
}
