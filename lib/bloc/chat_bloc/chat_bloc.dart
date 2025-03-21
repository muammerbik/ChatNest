import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Repository repository = locator<Repository>();

  ChatBloc() : super(ChatState(status: ChatStatus.init, chatList: [])) {
    on<GetAllConversationsEvent>(_getAllConversations);
    on<ChatDeleteEvent>(_chatDelete);
  }

  Future<void> _getAllConversations(
      GetAllConversationsEvent event, Emitter<ChatState> emit) async {
    try {
      /*     debugPrint("ChatBloc: Loading conversations");
      emit(state.copyWith(status: ChatStatus.loading)); */

      final newList = await repository.getAllConversations(event.userId);
      debugPrint("ChatBloc: Loaded ${newList.length} conversations");

      emit(state.copyWith(status: ChatStatus.success, chatList: newList));
      debugPrint("ChatBloc: State updated with conversations");
    } catch (e) {
      debugPrint("ChatBloc: Error loading conversations - $e");
      emit(state.copyWith(status: ChatStatus.error));
    }
  }

  Future<void> _chatDelete(
      ChatDeleteEvent event, Emitter<ChatState> emit) async {
    try {
      final result =
          await repository.chatDelete(event.currentUserId, event.chattedUserId);

      if (result) {
        // After successful deletion, get the updated conversation list
        add(GetAllConversationsEvent(userId: event.currentUserId));
      } else {
        emit(state.copyWith(status: ChatStatus.error));
      }
    } catch (e) {
      debugPrint("Chat deletion error: $e");
      emit(state.copyWith(status: ChatStatus.error));
    }
  }
}
