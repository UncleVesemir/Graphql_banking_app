import 'package:banking/src/domain/entities/card.dart';

class QueryMutation {
  String addCard() {
    return """
      mutation AddCard(\$card_name: String, \$card_value: String!, \$card_type: String!, \$card_cvv: Int!, \$card_user_id: Int!, \$card_exp_date: String!, \$card_number: String!) {
  insert_card_one(object: {card_number: \$card_number, card_name: \$card_name, card_value: \$card_value, card_type: \$card_type, card_cvv: \$card_cvv, card_user_id: \$card_user_id, card_exp_date: \$card_exp_date}) {
    card_id
    card_name
    card_number
    card_value
    card_type
    card_cvv
    card_user_id
    card_exp_date
  }
}
""";
  }

  Map<String, dynamic> addCardVariables(Card model) {
    return {
      'card_number': model.number,
      'card_name': model.name,
      'card_exp_date': model.expDate,
      'card_value': model.value,
      'card_type': model.type,
      'card_cvv': model.cvv,
      'card_user_id': model.userId,
    };
  }

  String fetchCards() {
    return """
      subscription FetchCards(\$user_id: Int!) {
        card(where: {card_user_id: {_eq: \$user_id}}) {
          card_cvv
          card_exp_date
          card_id
          card_name
          card_number
          card_type
          card_user_id
          card_value
        }
      }
    """;
  }

  Map<String, dynamic> fetchCardsVariables(int userId) {
    return {
      'user_id': userId,
    };
  }

  String fetchFriends() {
    return """
      subscription FetchFriends(\$user_uuid: uuid!) {
        friends(where: {user_first_uuid: {_eq: \$user_uuid}}) {
          user_first_uuid
          user_second_uuid
          id
          status
        }
      }
    """;
  }

  Map<String, dynamic> fetchFriendsVariables(String userUuid) {
    return {
      'user_uuid': userUuid,
    };
  }

  String updateImage() {
    return """
      mutation UpdateImage(\$user_id: Int!, \$file: String!) {
  update_user(where: {user_id: {_eq: \$user_id}}, _set: {user_image: \$file}) {
    returning {
      user_image
    }
  }
}
""";
  }

  Map<String, dynamic> updateImageVariables(int userId, String file) {
    return {
      'user_id': userId,
      'file': file,
    };
  }

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
            user_uuid
            user_id
            user_email
            user_password
            user_name
            user_image
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
          user_image
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
