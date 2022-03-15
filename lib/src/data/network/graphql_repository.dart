import 'package:banking/src/data/network/graphql_provider.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/presentation/blocs/bloc/sign_in_register_bloc.dart';

class GraphQLRepositiry {
  final UserProvider _userProvider = UserProvider();
  Future<User> login(SignInEvent data) => _userProvider.login(data);
  Future<User> register(RegisterEvent data) => _userProvider.register(data);
  Future<User> uploadImage(UploadImageEvent data) =>
      _userProvider.uploadImage(data);
}
