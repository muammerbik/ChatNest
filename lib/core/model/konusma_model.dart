import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String conversationOwner; // Konuşma Sahibi
  final String talkingTo; // Kimle Konuşuyor
  final bool isRead; // Görüldü
  final Timestamp createdAt; // Oluşturulma Tarihi
  final String lastSentMessage; // Son Yollanan Mesaj
  final Timestamp lastSeen; // Son Görülme
  String? talkingToUserName;
  String? talkingToUserProfileUrl; 
  DateTime? lastReadTime; // Son Okuma Zamanı
  String? timeDifference; // Saat Farkı

  ConversationModel({
    required this.conversationOwner,
    required this.talkingTo,
    required this.isRead,
    required this.createdAt,
    required this.lastSentMessage,
    required this.lastSeen,
    this.talkingToUserName,
    this.talkingToUserProfileUrl, 
  });

  Map<String, dynamic> toMap() {
    return {
      'conversationOwner': conversationOwner,
      'talkingTo': talkingTo,
      'isRead': isRead,
      'createdAt': createdAt,
      'lastSentMessage': lastSentMessage,
      'lastSeen': lastSeen,
      'talkingToUserName': talkingToUserName,
      'talkingToUserProfileUrl': talkingToUserProfileUrl,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      conversationOwner: map['conversationOwner'] ?? '',
      talkingTo: map['talkingTo'] ?? '',
      isRead: map['isRead'] ?? false,
      createdAt: (map['createdAt'] as Timestamp?) ?? Timestamp.now(),
      lastSentMessage: map['lastSentMessage'] ?? '',
      lastSeen: (map['lastSeen'] as Timestamp?) ?? Timestamp.now(),
      talkingToUserName: map['talkingToUserName'],
      talkingToUserProfileUrl: map['talkingToUserProfileUrl'],
    );
  }

  @override
  String toString() {
    return 'ConversationModel(conversationOwner: $conversationOwner, talkingTo: $talkingTo, isRead: $isRead, createdAt: $createdAt, lastSentMessage: $lastSentMessage, lastSeen: $lastSeen, talkingToUserName: $talkingToUserName, talkingToUserProfileUrl: $talkingToUserProfileUrl)';
  }
}
