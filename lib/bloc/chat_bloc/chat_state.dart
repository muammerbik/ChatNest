import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { init, loading, success, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<KonusmaModel> chatList;
  final KonusmaModel? konusmaModel;
  final UserModel userModel;

  const ChatState({
    required this.status,
    required this.chatList,
    this.konusmaModel,
    required this.userModel,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<KonusmaModel>? chatList,
    KonusmaModel? konusmaModel,
    UserModel? userModel,
  }) {
    return ChatState(
        status: status ?? this.status,
        chatList: chatList ?? this.chatList,
        konusmaModel: konusmaModel ?? this.konusmaModel,
        userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [status, chatList, konusmaModel, userModel];
}
