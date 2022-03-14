import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/domain/entities/user.dart';
import 'package:banking/src/internal/application.dart';
import 'package:banking/src/presentation/blocs/bloc/sign_in_register_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProvider {
  QueryMutation addMutation = QueryMutation();

  Future<User> login(SignInEvent data) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.login()),
        variables: addMutation.loginVariables(data.email, data.password),
      ),
    );
    if (result.hasException) {
      print(result.exception);
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

  Future<User> register(RegisterEvent data) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(addMutation.createUser()),
        variables: addMutation.createUserVariables(
            data.email, data.password, data.name),
      ),
    );
    if (result.hasException) {
      // UtilsWidget.showInfoSnackBar(
      //   context,
      //   'This email already taken',
      // );
      throw Exception('Email already taken');
    } else {
      if (result.data!['insert_user_one'].toString().length > 10) {
        print(result.data!['insert_user_one'].toString());
        var user = UserModel.fromJson(result.data!['insert_user_one']);
        // UtilsWidget.navigateToScreen(context, const Home());
        // UtilsWidget.showInfoSnackBar(
        //   context,
        //   'Logged as $name',
        // );
        return user;
      } else {
        // print(result.data.toString());
        // UtilsWidget.showInfoSnackBar(
        //   context,
        //   'Something gone wrong. Try again',
        // );
        throw Exception('Something gone wrong. Try again');
      }
    }
  }
}
