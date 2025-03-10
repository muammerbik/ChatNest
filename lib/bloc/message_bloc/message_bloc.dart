import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final Repository repository = locator<Repository>();
  StreamSubscription? _messagesSubscription;

  MessageBloc()
      : super(MessageState(
          status: MessageStatus.init,
          messageList: [],
          mesajModel:
              MesajModel(kimden: "", kime: "", bendenMi: false, mesaj: ""),
        )) {
    on<GetMessageEvent>(getMessage);
    on<SaveMessageEvent>(saveMessage);
  }
Future<void> getMessage(GetMessageEvent event, Emitter<MessageState> emit) async {
  try {
    emit(state.copyWith(status: MessageStatus.loading));
    _messagesSubscription?.cancel();
    
    // Mesajları sadece iki kullanıcı arasında filtrele
    _messagesSubscription = repository
        .getMessagers(event.currentUserId, event.sohbetEdilenUserId)
        .listen((messages) {
      // Filtreleme: sadece şu anki kullanıcı ve sohbet edilen kullanıcı arasındaki mesajları göster
      final filteredMessages = messages.where((message) {
        return (message.kimden == event.currentUserId && message.kime == event.sohbetEdilenUserId) ||
               (message.kimden == event.sohbetEdilenUserId && message.kime == event.currentUserId);
      }).toList();

      emit(state.copyWith(
        status: MessageStatus.success,
        messageList: filteredMessages,
      ));
    }, onError: (error) {
      emit(state.copyWith(status: MessageStatus.error));
    });
  } catch (e) {
    emit(state.copyWith(status: MessageStatus.error));
  }
}
Future<void> saveMessage(SaveMessageEvent event, Emitter<MessageState> emit) async {
  try {
    emit(state.copyWith(status: MessageStatus.loading));
    final isSaved = await repository.saveMessages(event.kaydedilecekMesaj);

    if (isSaved) {
      final updatedMessages = List<MesajModel>.from(state.messageList)
        ..insert(0, event.kaydedilecekMesaj); // Mesajı başa ekle

      emit(state.copyWith(
        status: MessageStatus.success,
        messageList: updatedMessages,
      ));
    } else {
      emit(state.copyWith(status: MessageStatus.error));
    }
  } catch (e) {
    emit(state.copyWith(status: MessageStatus.error));
  }
}


  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
