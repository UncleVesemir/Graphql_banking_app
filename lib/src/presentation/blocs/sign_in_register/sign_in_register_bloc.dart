import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_register_event.dart';
part 'sign_in_register_state.dart';

class SignInRegisterBloc
    extends Bloc<SignInRegisterEvent, SignInRegisterState> {
  final GraphQLRepositiry graphQLRepositiry;

  SignInRegisterBloc({required this.graphQLRepositiry})
      : super(SignInRegisterEmptyState()) {
    // Login
    on<SignInEvent>((event, emit) async {
      emit(SignInRegisterLoadingState());
      try {
        final User user = await graphQLRepositiry.login(event);
        emit(SignInRegisterLoadedState(user: user));
      } catch (e) {
        emit(SignInRegisterErrorState(e.toString()));
      }
    });
    // Registration
    on<RegisterEvent>((event, emit) async {
      emit(SignInRegisterLoadingState());
      try {
        final User user = await graphQLRepositiry.register(event);
        emit(SignInRegisterLoadedState(user: user));
      } catch (e) {
        emit(SignInRegisterErrorState(e.toString()));
      }
    });
    // Upload Image
    on<UploadImageEvent>((event, emit) async {
      emit(SignInRegisterLoadingState());
      try {
        final User user = await graphQLRepositiry.uploadImage(event);
        emit(SignInRegisterLoadedState(user: user));
      } catch (e) {
        emit(SignInRegisterErrorState(e.toString()));
      }
    });
  }
}
