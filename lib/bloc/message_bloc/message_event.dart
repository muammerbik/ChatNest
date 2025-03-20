part of 'message_bloc.dart';

class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessageEvent extends MessageEvent {
  final String currentUserId;
  final String chattedUserId;

  const GetMessageEvent({
    required this.currentUserId,
    required this.chattedUserId,
  });

  @override
  List<Object> get props => [currentUserId, chattedUserId];
}

class SaveMessageEvent extends MessageEvent {
  final MessageModel savedMessage;

  const SaveMessageEvent({required this.savedMessage});

  @override
  List<Object> get props => [savedMessage];
}