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
  final List<Friend>? friends;
  final List<Friend>? requests;
  final List<Friend>? search;
  const UpdateDataEvent({
    this.friends,
    this.requests,
    this.search,
  });
}

class SearchFriendEvent extends FriendsEvent {
  final int id;
  final String? text;
  const SearchFriendEvent({required this.id, required this.text});
}

class ConfirmFriendEvent extends FriendsEvent {}

class RemoveFriendEvent extends FriendsEvent {}

class RequestFriendEvent extends FriendsEvent {}
