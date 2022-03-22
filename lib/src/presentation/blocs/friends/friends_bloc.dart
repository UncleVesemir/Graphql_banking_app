import 'dart:async';

import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
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
      emit(FriendsLoadingState());
      emit(FriendsLoadedState(friends: event.friends));
    });
    on<FetchFriendsEvent>((event, emit) {
      emit(FriendsLoadingState());
      try {
        Stream<QueryResult<dynamic>> stream = graphQLRepositiry
            .fetchFriends(FetchFriendsEvent(userId: event.userId));
        streamSubscription = stream.listen((event) async {
          List<User> friends = [];
          print(event.data);
          // for (var i = 0; i < event.data!['friend'].length; i++) {
          // friends.add(UserModel.fromJson(event.data!['friend'][i]));
          // }
          // add(UpdateDataEvent(friends: []));
        });
      } catch (e) {
        print(e);
      }
    });
  }
}
