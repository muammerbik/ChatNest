import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { init, loading, success, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ConversationModel> chatList;

  const ChatState({
    required this.status,
    required this.chatList,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ConversationModel>? chatList,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatList: chatList ?? this.chatList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        chatList,
      ];
}
