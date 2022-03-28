part of 'operations_bloc_bloc.dart';

abstract class OperationsBlocState extends Equatable {
  const OperationsBlocState();

  @override
  List<Object> get props => [];
}

class OperationsEmptyState extends OperationsBlocState {}

class OperationsLoadedState extends OperationsBlocState {
  final List<op.Operation> operations;
  const OperationsLoadedState({required this.operations});
}

class OperationsLoadingState extends OperationsBlocState {}
