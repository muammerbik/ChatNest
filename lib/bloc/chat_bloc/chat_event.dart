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
