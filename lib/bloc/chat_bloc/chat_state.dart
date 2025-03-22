import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum ChatStatus { init, loading, success, error }

// ignore: must_be_immutable
class ChatState extends Equatable {
  final ChatStatus status;
  final List<ConversationModel> chatList;
  final List<ConversationModel> searchList;
  TextEditingController searchController = TextEditingController();

  ChatState({
    required this.status,
    required this.chatList,
    required this.searchList,
    required this.searchController,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ConversationModel>? chatList,
    List<ConversationModel>? searchList,
    TextEditingController? searchController,
  }) {
    return ChatState(
        status: status ?? this.status,
        chatList: chatList ?? this.chatList,
        searchList: searchList ?? this.searchList,
        searchController: searchController ?? this.searchController);
  }

  @override
  List<Object?> get props => [status, chatList, searchList, searchController];
}
