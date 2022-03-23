import 'dart:async';

import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/friend.dart';
import 'package:banking/src/domain/entities/user.dart';
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
    on<UpdateDataEvent>((event, emit) {
      emit(
        FriendsLoadedState(
          friends: event.friends,
          requests: event.requests,
          search: event.search,
        ),
      );
    });
    on<SearchFriendEvent>((event, emit) async {
      if (streamSubscription != null) {
        streamSubscription!.cancel();
        streamSubscription = null;
      }
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
            add(UpdateDataEvent(search: result));
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
            for (var friend in event.data!['friends']) {
              var user = Friend(
                info: await graphQLRepositiry
                    .fetchProfileInfo(friend['user_second_id']),
                status: friend['status'],
              );
              user.status == 'confirmed'
                  ? friends.add(user)
                  : requests.add(user);
            }
          }
          add(UpdateDataEvent(friends: friends, requests: requests));
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
