import 'package:banking/src/data/network/graphql_provider.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
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
  Stream<QueryResult<dynamic>> fetchCards(FetchCardsEvent data) =>
      _userProvider.fetchCards(data);
  Future<User> fetchProfileInfo(int id) => _userProvider.fetchProfileInfo(id);
  Future<List<User>?> searchUsers(String text) =>
      _userProvider.searchUsers(text);
  Future<String?> checkUserFriend(int userId, int friendId) =>
      _userProvider.checkUserFriend(userId, friendId);
  Future<bool> confirmRequestFriend(ConfirmRequestFriendEvent data) =>
      _userProvider.confirmFriend(
        data.status,
        data.userId,
        data.friendId,
      );
  Future<bool> deleteFriend(DeleteFriendEvent data) =>
      _userProvider.deleteFriend(
        data.userId,
        data.friendId,
      );
  Future<bool> requestFriend(RequestFriendEvent data) =>
      _userProvider.requestFriend(
        data.userId,
        data.friendId,
      );
  Future<bool> declineRequest(DeclineRequestEvent data) =>
      _userProvider.declineRequest(
        data.userId,
        data.friendId,
      );
}
