// ignore_for_file: avoid_print

import 'dart:async';

import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/data/notifications/notification_api.dart';
import 'package:banking/src/domain/entities/friend.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GraphQLRepositiry graphQLRepositiry;
  final SignInRegisterBloc signInRegisterBloc;
  StreamSubscription? streamSubscription;
  FriendsBloc({
    required this.graphQLRepositiry,
    required this.signInRegisterBloc,
  }) : super(FriendsEmptyState()) {
    streamSubscription = signInRegisterBloc.stream.listen((state) {});
    streamSubscription!.onData((state) {
      if (state is SignInRegisterLoadedState) {
        add(FetchFriendsEvent(userId: state.user.id));
      }
    });
    on<ConfirmRequestFriendEvent>((event, emit) async {
      try {
        bool isSuccesfull = await graphQLRepositiry.confirmRequestFriend(event);
        if (isSuccesfull) {
          print('Succes');
        } else {
          print('Error');
        }
      } catch (e) {
        print(e);
      }
    });

    on<DeleteFriendEvent>((event, emit) async {
      try {
        bool isSuccesfull = await graphQLRepositiry.deleteFriend(event);
        if (isSuccesfull) {
          print('Succes');
        } else {
          print('Error');
        }
      } catch (e) {
        print(e);
      }
    });

    on<RequestFriendEvent>((event, emit) async {
      try {
        bool isSuccesfull = await graphQLRepositiry.requestFriend(event);
        if (isSuccesfull) {
          print('Succes');
        } else {
          print('Error');
        }
      } catch (e) {
        print(e);
      }
    });

    on<DeclineRequestEvent>((event, emit) async {
      try {
        bool isSuccesfull = await graphQLRepositiry.declineRequest(event);
        if (isSuccesfull) {
          print('Succes');
        } else {
          print('Error');
        }
      } catch (e) {
        print(e);
      }
    });
    on<UpdateFriendDataEvent>((event, emit) {
      emit(FriendsLoadingState());
      emit(
        FriendsLoadedState(
          friends: event.friends,
          requests: event.requests,
          search: event.search,
        ),
      );
    });
    on<SearchFriendEvent>((event, emit) async {
      _closeStream();
      emit(FriendsLoadingState());
      try {
        if (event.text != null) {
          List<Friend> result = [];
          var users = await graphQLRepositiry.searchUsers(event.text!);
          if (users != null) {
            for (var user in users) {
              String? status =
                  await graphQLRepositiry.checkUserFriend(event.id, user.id);
              status == null
                  ? result.add(Friend(info: user, status: '', cards: null))
                  : result.add(Friend(info: user, status: status, cards: null));
            }
            add(UpdateFriendDataEvent(
              search: result,
              friends: const [],
              requests: const [],
            ));
          }
        }
      } catch (e) {
        print(e);
      }
    });
    on<FetchFriendsEvent>((event, emit) {
      emit(FriendsLoadingState());
      try {
        Stream<QueryResult<dynamic>> stream = graphQLRepositiry
            .fetchFriends(FetchFriendsEvent(userId: event.userId));
        streamSubscription = stream.listen((event) async {
          List<Friend> friends = [];
          List<Friend> requests = [];
          if (event.data != null && event.data!.isNotEmpty) {
            print('friends updated');
            for (var friend in event.data!['friends']) {
              var info = await graphQLRepositiry
                  .fetchProfileInfo(friend['user_second_id']);
              var user = Friend(
                info: info.info,
                status: friend['status'],
                cards: info.cards,
              );
              user.status == 'confirmed'
                  ? friends.add(user)
                  : requests.add(user);
            }
          }
          add(UpdateFriendDataEvent(
            friends: friends,
            requests: requests,
            search: const [],
          ));
          await _showNotifications(requests);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  _showNotifications(List<Friend>? requests) {
    if (requests != null && requests.isNotEmpty) {
      NotificationService.showNotification(
          title: 'You have ${requests.length} friend requests');
    }
  }

  _closeStream() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
      streamSubscription = null;
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
