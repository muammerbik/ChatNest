part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetAllConversationsEvent extends ChatEvent {
  final String userId;

  const GetAllConversationsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ChatDeleteEvent extends ChatEvent {
  final String currentUserId;
  final String chattedUserId;

  const ChatDeleteEvent(
      {required this.currentUserId, required this.chattedUserId});
  @override
  List<Object> get props => [currentUserId, chattedUserId];
}

class SearchConversationsEvent extends ChatEvent {
  const SearchConversationsEvent();
  @override
  List<Object> get props => [];
}
