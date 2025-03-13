import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final Repository repository = locator<Repository>();

  MessageBloc()
      : super(MessageState(
          status: MessageStatus.init,
          messageList: [],
        )) {
    on<GetMessageEvent>(_onGetMessageEvent);
    on<SaveMessageEvent>(_onSaveMessageEvent);
  }

  Future<void> _onGetMessageEvent(
      GetMessageEvent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(status: MessageStatus.loading));

    try {
      final messagesStream = repository.getMessagers(
        event.currentUserId,
        event.sohbetEdilenUserId,
      );

      // Stream'den gelen mesajları dinle ve state'i güncelle
      await for (final messages in messagesStream) {
        emit(state.copyWith(
          status: MessageStatus.success,
          messageList: messages,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: MessageStatus.error));
      debugPrint("Get Messages Error: $e");
    }
  }

  Future<void> _onSaveMessageEvent(
      SaveMessageEvent event, Emitter<MessageState> emit) async {
    emit(state.copyWith(status: MessageStatus.loading));

    try {
      final isSaved = await repository.saveMessages(event.kaydedilecekMesaj);

      if (isSaved) {
        emit(state.copyWith(status: MessageStatus.success));
      } else {
        emit(state.copyWith(status: MessageStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: MessageStatus.error));
      debugPrint("Save Message Error: $e");
    }
  }
}