import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Repository repository = locator<Repository>();

  ChatBloc() : super(ChatState(status: ChatStatus.init, chatList: [],userModel: UserModel(userId: "", email: ""))) {
    on<GetAllConversationsEvent>(getAllConversations);
  }

  Future<void> getAllConversations(
      GetAllConversationsEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));

      final newList = await repository.getAllConversations(event.userId);
      emit(state.copyWith(status: ChatStatus.success, chatList: newList));
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error));
    }
  }
}