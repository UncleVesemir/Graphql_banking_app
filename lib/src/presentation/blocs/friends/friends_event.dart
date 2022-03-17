part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class FetchFriendsEvent extends FriendsEvent {}

class ConfirmFriendEvent extends FriendsEvent {}

class RemoveFriendEvent extends FriendsEvent {}

class RequestFriendEvent extends FriendsEvent {}
