import 'package:banking/src/domain/entities/card.dart';

class QueryMutation {
  String createUser() {
    return """
      mutation CreateUser(
        \$email: String!, 
        \$password: String!, 
        \$name: String!
        ) {
        insert_user_one(
          object: {
            user_email: \$email, 
            user_password: \$password, 
            user_name: \$name
          }) {
            user_id
            user_email
            user_password
            user_name
          }
      }
      """;
  }

  Map<String, String> createUserVariables(
      String email, String password, String name) {
    return {
      "email": email,
      "password": password,
      "name": name,
    };
  }

  String login() {
    return """
      query Login(\$email: String!, \$password: String!) {
        user(where: {
          user_email: {_eq: \$email}, 
          user_password: {_eq: \$password}
          }) {
          user_id
          user_uuid
          user_name
          user_email
          user_password
          }
      }
      """;
  }

  Map<String, String> loginVariables(String email, String password) {
    return {
      "email": email,
      "password": password,
    };
  }

  String addCard(Card object) {
    return """
      mutation AddCard($object: card_insert_input!) {
        insert_card_one(object: $object) {
          card_id
        }
      }
      """;
  }

  String deleteCard() {
    return """
      mutation DeleteCard(\$card_id: Int!) {
        delete_card_by_pk(card_id: \$card_id) {
          card_id
        }
      }
      """;
  }

  Map<String, String> deleteCardVariables(int cardId) {
    return {"card_id": "$cardId"};
  }

  //
}
