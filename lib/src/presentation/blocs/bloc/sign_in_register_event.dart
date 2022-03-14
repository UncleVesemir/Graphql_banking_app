part of 'sign_in_register_bloc.dart';

abstract class SignInRegisterEvent extends Equatable {
  const SignInRegisterEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends SignInRegisterEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});
}

class RegisterEvent extends SignInRegisterEvent {
  final String email;
  final String password;
  final String name;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}
