// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String sender; // Kimden (Gönderen kişi)
  final String receiver; // Kime (Alıcı kişi)
  final Timestamp? timestamp; // Tarih (Mesajın gönderilme zamanı)
  final bool isSentByMe; // Benden Mi (Mesajın benden gelip gelmediğini belirten boolean)
  final String content; // Mesaj içeriği

  MessageModel({
    required this.sender,
    required this.receiver,
    this.timestamp,
    required this.isSentByMe,
    required this.content,
  });

  // Mesajı Map formatında döndürme
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
      'isSentByMe': isSentByMe,
      'content': content,
    };
  }

  // Map formatındaki veriden MessageModel nesnesi oluşturma
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      timestamp: map['timestamp'],
      isSentByMe: map['isSentByMe'] as bool,
      content: map['content'] as String,
    );
  }

  // JSON formatında bir string döndürme
  String toJson() => json.encode(toMap());

  // JSON string'inden MessageModel nesnesi oluşturma
  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(sender: $sender, receiver: $receiver, timestamp: $timestamp, isSentByMe: $isSentByMe, content: $content)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.receiver == receiver &&
        other.timestamp == timestamp &&
        other.isSentByMe == isSentByMe &&
        other.content == content;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        receiver.hashCode ^
        timestamp.hashCode ^
        isSentByMe.hashCode ^
        content.hashCode;
  }
}
