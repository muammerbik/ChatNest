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
    on<GetAllConversationsEvent>(getAllConversations);
  }

  Future<void> getAllConversations(
      GetAllConversationsEvent event, Emitter<ChatState> emit) async {
    try {
      debugPrint("ChatBloc: Loading conversations");
      emit(state.copyWith(status: ChatStatus.loading));

      final newList = await repository.getAllConversations(event.userId);
      debugPrint("ChatBloc: Loaded ${newList.length} conversations");
      
      emit(state.copyWith(status: ChatStatus.success, chatList: newList));
      debugPrint("ChatBloc: State updated with conversations");
    } catch (e) {
      debugPrint("ChatBloc: Error loading conversations - $e");
      emit(state.copyWith(status: ChatStatus.error));
    }
  }
}