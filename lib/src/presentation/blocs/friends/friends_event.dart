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

class UpdateFriendDataEvent extends FriendsEvent {
  final List<Friend> friends;
  final List<Friend> requests;
  final List<Friend> search;
  const UpdateFriendDataEvent({
    required this.friends,
    required this.requests,
    required this.search,
  });
}

class SearchFriendEvent extends FriendsEvent {
  final int id;
  final String? text;
  const SearchFriendEvent({required this.id, required this.text});
}

class ConfirmRequestFriendEvent extends FriendsEvent {
  final String status;
  final int userId;
  final int friendId;
  const ConfirmRequestFriendEvent({
    required this.status,
    required this.userId,
    required this.friendId,
  });
}

class RequestFriendEvent extends FriendsEvent {
  final int userId;
  final int friendId;
  const RequestFriendEvent({
    required this.userId,
    required this.friendId,
  });
}

class DeleteFriendEvent extends FriendsEvent {
  final int userId;
  final int friendId;
  const DeleteFriendEvent({
    required this.userId,
    required this.friendId,
  });
}

class DeclineRequestEvent extends FriendsEvent {
  final int userId;
  final int friendId;
  const DeclineRequestEvent({
    required this.userId,
    required this.friendId,
  });
}
