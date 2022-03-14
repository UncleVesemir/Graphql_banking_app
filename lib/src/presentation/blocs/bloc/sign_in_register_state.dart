part of 'sign_in_register_bloc.dart';

abstract class SignInRegisterState extends Equatable {
  const SignInRegisterState();

  @override
  List<Object> get props => [];
}

class SignInRegisterEmptyState extends SignInRegisterState {}

class SignInRegisterLoadingState extends SignInRegisterState {}

class SignInRegisterDoneState extends SignInRegisterState {
  final User user;
  const SignInRegisterDoneState({required this.user});
}

class SignInRegisterErrorState extends SignInRegisterState {
  final String error;
  const SignInRegisterErrorState(this.error);
}
