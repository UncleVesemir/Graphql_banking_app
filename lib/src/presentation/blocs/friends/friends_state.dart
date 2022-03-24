part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsEmptyState extends FriendsState {}

class FriendsLoadingState extends FriendsState {}

class FriendsLoadedState extends FriendsState {
  final List<Friend> friends;
  final List<Friend> requests;
  final List<Friend> search;
  const FriendsLoadedState({
    required this.friends,
    required this.requests,
    required this.search,
  });
}

class FriendsErrorState extends FriendsState {}
