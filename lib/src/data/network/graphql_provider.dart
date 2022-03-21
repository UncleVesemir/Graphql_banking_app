import 'package:banking/src/data/models/card.dart';
import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/internal/application.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
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
        print(result.data!['user'].toString());
        var user = UserModel.fromJson(result.data!['user'][0]);
        return user;
      } else {
        throw Exception('Incorrect email or password');
      }
    }
    throw Exception('Something gone wrong. Try again');
  }

  Stream<QueryResult<dynamic>> fetchFriends(FetchFriendsEvent data) {
    Stream<QueryResult<dynamic>> stream;
    stream = _client.subscribe(SubscriptionOptions(
      document: gql(addMutation.fetchFriends()),
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
        print(result.data!['update_user']['returning'][0].toString());
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
