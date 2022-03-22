part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class FetchFriendsEvent extends FriendsEvent {
  final int userId;
  const FetchFriendsEvent({required this.userId});
}

class UpdateDataEvent extends FriendsEvent {
  final List<User> friends;
  const UpdateDataEvent({required this.friends});
}

class ConfirmFriendEvent extends FriendsEvent {}

class RemoveFriendEvent extends FriendsEvent {}

class RequestFriendEvent extends FriendsEvent {}
