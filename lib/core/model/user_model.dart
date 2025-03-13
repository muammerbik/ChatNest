// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  String email;
  String? userName;
  String? surname;
  String? profileUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel({
    required this.userId,
    required this.email,
    this.userName,
    this.surname,
    this.profileUrl,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    String? userId,
    String? email,
    String? userName,
    String? surname,
    String? profileUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      surname: surname ?? this.surname,
      profileUrl: profileUrl ?? this.profileUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  UserModel.withIdAndProfileUrl({
    required this.userId,
    String? profileUrl,
    String? userName,
  })  : email = '',
        userName = userName,
        profileUrl = profileUrl,
        createdAt = null,
        updatedAt = null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'userName': userName ??
          email.substring(
                0,
                email.indexOf("@"),
              ) +
              randomNumber(),
      'surname': surname,
      'profileUrl': profileUrl ,
      'createdAt':
          createdAt?.millisecondsSinceEpoch ?? FieldValue.serverTimestamp(),
      'updatedAt':
          updatedAt?.millisecondsSinceEpoch ?? FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      userName: map['userName'] as String? ??"",
      surname: map['surname'] as String? ?? "",
      profileUrl: map['profileUrl'] as String? ??
          "",
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, userName: $userName,surname $surname, profileUrl: $profileUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.userName == userName &&
        other.surname == surname &&
        other.profileUrl == profileUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        surname.hashCode ^
        profileUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  String randomNumber() {
    int generatedRandomNumber = Random().nextInt(999999);
    return generatedRandomNumber.toString();
  }
}
