part of 'message_bloc.dart';

enum MessageStatus { init, loading, success, error }

class MessageState extends Equatable {
  final MessageStatus status;
  final List<MessageModel> messageList;

  const MessageState({
    required this.status,
    required this.messageList,
  });

  MessageState copyWith({
    MessageStatus? status,
    List<MessageModel>? messageList,
  }) {
    return MessageState(
      status: status ?? this.status,
      messageList: messageList ?? this.messageList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messageList,
      ];
}
