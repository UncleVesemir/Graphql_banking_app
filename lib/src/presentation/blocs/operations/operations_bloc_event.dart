part of 'operations_bloc_bloc.dart';

abstract class OperationsBlocEvent extends Equatable {
  const OperationsBlocEvent();

  @override
  List<Object> get props => [];
}

class AddOperationEvent extends OperationsBlocEvent {
  final op.Operation operation;
  const AddOperationEvent({required this.operation});
}

class FetchOperationsEvent extends OperationsBlocEvent {
  final int userId;
  const FetchOperationsEvent({required this.userId});
}

class UpdateOperationsDataEvent extends OperationsBlocEvent {
  final List<op.Operation> operations;
  const UpdateOperationsDataEvent({required this.operations});
}

class UpdateOperationStatusEvent extends OperationsBlocEvent {
  final int operationId;
  final String status;
  const UpdateOperationStatusEvent(
      {required this.operationId, required this.status});
}

class ErrorOperationEvent extends OperationsBlocEvent {}
