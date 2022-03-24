import 'package:banking/src/domain/entities/card.dart';

class QueryMutation {
  String declineRequest() {
    return """
      mutation DeclineRequest(
        \$first_id: Int!, 
        \$second_id: Int!) {
          delete_friends(where: {_or: [
            {
              status: {_eq: "requested"}, 
              user_first_id: {_eq: \$first_id}, 
              user_second_id: {_eq: \$second_id}
            }
          ]}) {
            returning{
              __typename
            }
          }
      }
    """;
  }

  String deleteFriend() {
    return """
      mutation DeleteFriend(
        \$first_id: Int!, 
        \$second_id: Int!) {
          delete_friends(where: {_or: [
            {
              status: {_eq: "confirmed"}, 
              	user_first_id: {_eq: \$first_id}, 
              	user_second_id: {_eq: \$second_id}
              },
              {
                status: {_eq: "confirmed"}, 
                user_first_id: {_eq: \$second_id}, 
                user_second_id: {_eq: \$first_id}
              }
          ]}) {
            returning{
              __typename
            }
        }
      }
    """;
  }

  String requestFriend() {
    return """
      mutation RequestFriend(
        \$first_id: Int!, 
        \$second_id: Int!) {
  	      insert_friends(objects:
            {status: "requested", user_first_id: \$second_id, user_second_id: \$first_id}
        ) {
          returning{
            __typename
          }
        }
      }
    """;
  }

  Map<String, dynamic> deleteAddDeclineFriendVariables(
    int firstId,
    int secondId,
  ) {
    return {
      'first_id': firstId,
      'second_id': secondId,
    };
  }

  String confirmFriend() {
    return """
      mutation ChangeFriendStatus(
        \$status: String!,
        \$first_id: Int!, 
        \$second_id: Int!) {
          delete_friends(where: {_or: [
            	{
                status: {_eq: "requested"}, 
                user_first_id: {_eq: \$first_id}, 
                user_second_id: {_eq: \$second_id}
              }
          ]}) {
            returning {
              __typename
            }
          }
          insert_friends(
            objects: [
              {
                status: \$status, 
                user_first_id: \$first_id, 
                user_second_id: \$second_id
              }, 
              {
                status: \$status, 
                user_first_id: \$second_id, 
                user_second_id: \$first_id
              } 
            ]) {
            returning {
              __typename
            }
        } 
      }
    """;
  }

  Map<String, dynamic> confirmFriendVariables(
    String status,
    int firstId,
    int secondId,
  ) {
    return {
      'status': status,
      'first_id': firstId,
      'second_id': secondId,
    };
  }

  String searchUsers() {
    return """
      query SearchUsers(\$search: String!) {
        user(where: {user_name: {_regex: \$search}}) {
          user_id
          user_name
          user_image
          user_email
        }
      }
    """;
  }

  Map<String, dynamic> searchUsersVariables(String search) {
    return {
      'search': search,
    };
  }

  String checkUserFriend() {
    return """
      query checkUserFriends(\$user_id: Int!, \$friend_id: Int!) {
        user_by_pk(user_id: \$user_id) {
          friends(where: {user_second_id: {_eq: \$friend_id}}) {
            status
          }
        }
      }
    """;
  }

  Map<String, dynamic> checkUserFriendVariables(int userId, int friendId) {
    return {
      'user_id': userId,
      'friend_id': friendId,
    };
  }

  String fetchUserFriends() {
    return """
      subscription FetchFriends(\$user_id: Int!) {
        friends(where: {user_first_id: {_eq: \$user_id}}) {
          user_first_id
          user_second_id
          status
        }
      }
    """;
  }

  Map<String, dynamic> fetchFriendsVariables(int userId) {
    return {
      'user_id': userId,
    };
  }

  String getProfileInfo() {
    return """
      query GetProfileInfo(\$user_id: Int!) {
        user(where: {user_id: {_eq: \$user_id}}) {
          user_email
          user_image
          user_name
          user_id
        }
      }
    """;
  }

  Map<String, dynamic> getProfileInfoVariables(int userId) {
    return {
      'user_id': userId,
    };
  }

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
