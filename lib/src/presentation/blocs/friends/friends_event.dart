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
  final List<Friend> friends;
  final List<Friend> requests;
  const UpdateDataEvent({required this.friends, required this.requests});
}

class ConfirmFriendEvent extends FriendsEvent {}

class RemoveFriendEvent extends FriendsEvent {}

class RequestFriendEvent extends FriendsEvent {}
