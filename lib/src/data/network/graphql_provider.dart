import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/models/friend_card.dart';
import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/friend.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/internal/application.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:banking/src/presentation/blocs/history/history_bloc.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProvider {
  QueryMutation addMutation = QueryMutation();

  final GraphQLClient _client = graphQLConfiguration.clientToQuery();

  Future<User> login(SignInEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.login()),
        variables: addMutation.loginVariables(data.email, data.password),
      ),
    );
    if (result.hasException) {
      // print(result.exception);
    } else {
      if (result.data!['user'].toString().length > 10) {
        var user = UserModel.fromJson(result.data!['user'][0]);
        return user;
      } else {
        throw Exception('Incorrect email or password');
      }
    }
    throw Exception('Something gone wrong. Try again');
  }

  Future<List<User>?> searchUsers(String text) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.searchUsers()),
        variables: addMutation.searchUsersVariables(text),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        List<User> users = [];
        for (var user in result.data!['user']) {
          var person = UserModel.fromJson(user);
          users.add(person);
        }
        return users;
      } else {
        return null;
      }
    }
  }

  Future<bool> updateCardValue(UpdateCardValueEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.updateCardValue()),
        variables: addMutation.updateCardValueVariables(data),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> updateHistory(UpdateHistoryEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.updateHistory()),
        variables: addMutation.updateHistoryVariables(data),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> addHistory(AddHistoryEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.addHistory()),
        variables: addMutation.addHistoryVariables(data),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> addOperation(AddOperationEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.addOperation()),
        variables: addMutation.addOperationVariables(data),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<String?> checkUserFriend(int userId, int friendId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.checkUserFriend()),
        variables: addMutation.checkUserFriendVariables(userId, friendId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['user_by_pk']['friends'].toString().length > 10) {
          return (result.data!['user_by_pk']['friends'][0]['status']
              .toString());
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  Future<bool> confirmFriend(String status, int userId, int friendId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.confirmFriend()),
        variables: addMutation.confirmFriendVariables(status, userId, friendId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['insert_friends']['returning'].toString().length >
            10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> deleteFriend(int userId, int friendId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.deleteFriend()),
        variables:
            addMutation.deleteAddDeclineFriendVariables(userId, friendId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['delete_friends']['returning'].toString().length >
            10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> declineRequest(int userId, int friendId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.declineRequest()),
        variables:
            addMutation.deleteAddDeclineFriendVariables(userId, friendId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['delete_friends']['returning'].toString().length >
            10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> requestFriend(int userId, int friendId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.requestFriend()),
        variables:
            addMutation.deleteAddDeclineFriendVariables(userId, friendId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['insert_friends']['returning'].toString().length >
            10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> deleteOperation(int operationId) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.deleteOperation()),
        variables: addMutation.deleteOperationVariables(operationId),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['delete_operations_by_pk'].toString().length > 10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> updateOperationStatus(UpdateOperationStatusEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.updateOperationStatus()),
        variables: addMutation.updateOperationStatusVariables(data),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data != null && result.data!.isNotEmpty) {
        if (result.data!['update_operations_by_pk'].toString().length > 10) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<Friend> fetchProfileInfo(int id) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.getProfileInfo()),
        variables: addMutation.getProfileInfoVariables(id),
      ),
    );
    if (result.hasException) {
      // print(result.exception);
    } else {
      if (result.data!['user'].toString().length > 10) {
        var user = UserModel.fromJson(result.data!['user'][0]);
        List<FriendCardModel> cards = [];
        for (var card in result.data!['user'][0]['cards']) {
          cards.add(FriendCardModel.fromJson(card));
        }
        return Friend(info: user, status: '', cards: cards);
      } else {
        throw Exception('Error');
      }
    }
    throw Exception('Something gone wrong. Try again');
  }

  Stream<QueryResult<dynamic>> fetchHistory(FetchHistoryEvent data) {
    Stream<QueryResult<dynamic>> stream;
    stream = _client.subscribe(SubscriptionOptions(
      document: gql(addMutation.fetchHistory()),
      variables: addMutation.fetchHistoryVariables(
        FetchHistoryEvent(
          userId: data.userId,
        ),
      ),
    ));
    return stream;
  }

  Stream<QueryResult<dynamic>> fetchOperations(FetchOperationsEvent data) {
    Stream<QueryResult<dynamic>> stream;
    stream = _client.subscribe(SubscriptionOptions(
      document: gql(addMutation.fetchOperations()),
      variables: addMutation.fetchOperationsVariables(data.userId),
    ));
    return stream;
  }

  Stream<QueryResult<dynamic>> fetchFriends(FetchFriendsEvent data) {
    Stream<QueryResult<dynamic>> stream;
    stream = _client.subscribe(SubscriptionOptions(
      document: gql(addMutation.fetchUserFriends()),
      variables: addMutation.fetchFriendsVariables(data.userId),
    ));
    return stream;
  }

  Stream<QueryResult<dynamic>> fetchCards(FetchCardsEvent data) {
    Stream<QueryResult<dynamic>> stream;
    stream = _client.subscribe(SubscriptionOptions(
      document: gql(addMutation.fetchCards()),
      variables: addMutation.fetchCardsVariables(data.userId),
    ));
    return stream;
  }

  Future<User> register(RegisterEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.createUser()),
        variables: addMutation.createUserVariables(
            data.email, data.password, data.name),
      ),
    );
    if (result.hasException) {
      throw Exception('Email already taken');
    } else {
      if (result.data!['insert_user_one'].toString().length > 10) {
        // print(result.data!['insert_user_one'].toString());
        var user = UserModel.fromJson(result.data!['insert_user_one']);
        return user;
      } else {
        throw Exception('Something gone wrong. Try again');
      }
    }
  }

  Future<Card> addCard(AddCardEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.addCard()),
        variables: addMutation.addCardVariables(data.card),
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception);
    } else {
      if (result.data!['insert_card_one'].toString().length > 10) {
        var card = CardModel.fromJson(result.data!['insert_card_one']);
        return card;
      } else {
        throw Exception('Something gone wrong. Try again');
      }
    }
  }

  Future<User> uploadImage(UploadImageEvent data) async {
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.updateImage()),
        variables: addMutation.updateImageVariables(data.userId, data.file),
      ),
    );
    // print(result.toString());
    if (result.hasException) {
      // print(result.exception.toString());
    } else {
      if (result.data!['update_user']['returning'][0].toString().length > 10) {
        var user =
            UserModel.fromJson(result.data!['update_user']['returning'][0]);
        return user;
      } else {
        throw Exception('Incorrect email or password');
      }
    }
    throw Exception('Something gone wrong. Try again');
  }
}
