part of 'message_bloc.dart';

enum MessageStatus { init, loading, success, error }

class MessageState extends Equatable {
  final MessageStatus status;
  final List<MesajModel> messageList;
  final MesajModel mesajModel;

  const MessageState(
      {required this.status,
      required this.messageList,
      required this.mesajModel,
      });

  MessageState copyWith({
    MessageStatus? status,
    List<MesajModel>? messageList,
    MesajModel? mesajModel,
  }) {
    return MessageState(
      status: status ?? this.status,
      messageList: messageList ?? this.messageList,
      mesajModel: mesajModel ?? this.mesajModel,
    );
  }

  @override
  List<Object?> get props => [status, messageList, mesajModel];
}
