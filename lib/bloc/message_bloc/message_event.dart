part of 'message_bloc.dart';

class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessageEvent extends MessageEvent {
  final String currentUserId;
  final String sohbetEdilenUserId;

  const GetMessageEvent({
    required this.currentUserId,
    required this.sohbetEdilenUserId,
  });

  @override
  List<Object> get props => [currentUserId, sohbetEdilenUserId];
}

class SaveMessageEvent extends MessageEvent {
  final MesajModel kaydedilecekMesaj;

  const SaveMessageEvent({required this.kaydedilecekMesaj});

  @override
  List<Object> get props => [kaydedilecekMesaj];
}