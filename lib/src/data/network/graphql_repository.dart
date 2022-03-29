import 'package:banking/src/data/network/graphql_provider.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/friend.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:banking/src/presentation/blocs/history/history_bloc.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLRepositiry {
  final UserProvider _userProvider = UserProvider();

  /// LOGIN/SIGN IN
  Future<User> login(SignInEvent data) => _userProvider.login(data);
  Future<User> register(RegisterEvent data) => _userProvider.register(data);
  Future<User> uploadImage(UploadImageEvent data) =>
      _userProvider.uploadImage(data);

  /// CARDS
  Future<Card> addCard(AddCardEvent data) => _userProvider.addCard(data);
  Future<bool> updateCardValue(UpdateCardValueEvent data) =>
      _userProvider.updateCardValue(data);

  /// FRIENDS
  Stream<QueryResult<dynamic>> fetchFriends(FetchFriendsEvent data) =>
      _userProvider.fetchFriends(data);
  Stream<QueryResult<dynamic>> fetchCards(FetchCardsEvent data) =>
      _userProvider.fetchCards(data);
  Future<Friend> fetchProfileInfo(int id) => _userProvider.fetchProfileInfo(id);
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

  /// OPERATIONS
  Future<bool> addOperation(AddOperationEvent data) =>
      _userProvider.addOperation(data);
  Stream<QueryResult<dynamic>> fetchOperations(FetchOperationsEvent data) =>
      _userProvider.fetchOperations(data);
  Future<bool> updateStatus(UpdateOperationStatusEvent data) =>
      _userProvider.updateOperationStatus(data);
  Future<bool> deleteOperation(int operationId) =>
      _userProvider.deleteOperation(operationId);

  /// HISTORY
  Stream<QueryResult<dynamic>> fetchHistory(FetchHistoryEvent data) =>
      _userProvider.fetchHistory(data);
  Future<bool> updateHistory(UpdateHistoryEvent data) =>
      _userProvider.updateHistory(data);
  Future<bool> addHistory(AddHistoryEvent data) =>
      _userProvider.addHistory(data);
}
