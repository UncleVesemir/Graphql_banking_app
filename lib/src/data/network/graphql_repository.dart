import 'package:banking/src/data/network/graphql_provider.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLRepositiry {
  final UserProvider _userProvider = UserProvider();
  Future<User> login(SignInEvent data) => _userProvider.login(data);
  Future<User> register(RegisterEvent data) => _userProvider.register(data);
  Future<User> uploadImage(UploadImageEvent data) =>
      _userProvider.uploadImage(data);
  Future<Card> addCard(AddCardEvent data) => _userProvider.addCard(data);
  Stream<QueryResult<dynamic>> fetchFriends(FetchFriendsEvent data) =>
      _userProvider.fetchFriends(data);
}
