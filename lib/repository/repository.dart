import 'dart:io';
import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/core/service/auth_service/auth_base.dart';
import 'package:chat_menager/core/service/auth_service/firebase_auth_service.dart';
import 'package:chat_menager/core/service/firestore_service/firestore_services.dart';
import 'package:chat_menager/core/service/storage_service/storage_services.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:timeago/timeago.dart' as timeago;

class Repository implements AuthBase {
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  FirestoreServices fireStoreService = locator<FirestoreServices>();
  FirebaseStorageService firebaseStorage = locator<FirebaseStorageService>();
  List<UserModel> allPersonList = [];

  @override
  Future<UserModel?> currentUser() async {
    UserModel? userModel = await firebaseAuthService.currentUser();
    if (userModel != null) {
      return await fireStoreService.readUser(userModel.userId);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> singInAnonymously() async {
    return await firebaseAuthService.singInAnonymously();
  }

  @override
  Future<bool> singOut() async {
    return await firebaseAuthService.singOut();
  }

  @override
  Future<UserModel?> googleWithSingIn() async {
    UserModel? userModel = await firebaseAuthService.googleWithSingIn();
    if (userModel != null) {
      bool result = await fireStoreService.saveUser(userModel);
      if (result) {
        return await fireStoreService.readUser(userModel.userId);
      }
    }
    return null;
  }

  @override
  Future<UserModel?> createUserWithSingIn(String email, String password) async {
    UserModel? userModel =
        await firebaseAuthService.createUserWithSingIn(email, password);
    bool result = await fireStoreService.saveUser(userModel!);
    if (result) {
      return await fireStoreService.readUser(userModel.userId);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> emailAndPasswordWithSingIn(String email, String password) async {
    UserModel? userModel =
        await firebaseAuthService.emailAndPasswordWithSingIn(email, password);
    return await fireStoreService.readUser(userModel!.userId);
  }

  Future<bool> updateUserName(String userId, String newUserName) async {
    return await fireStoreService.updateUserName(userId, newUserName);
  }

  Future<String> uploadFile(
      String userId, String fileType, File? profilePhoto) async {
    var profilePhotoUrl =
        await firebaseStorage.uploadFile(userId, fileType, profilePhoto!);
    await fireStoreService.updateProfilePhoto(userId, profilePhotoUrl);
    return profilePhotoUrl;
  }


  Future<List<UserModel>> getUserWithPagination(
      UserModel? lastFetchedUser, int numberOfElementsToFetch) async {
    List<UserModel> userList = await fireStoreService.getUserWithPagination(
        lastFetchedUser, numberOfElementsToFetch);
    allPersonList.addAll(userList);
    return userList;
  }



  Stream<List<MessageModel>> getMessages(
      String currentUserId, String chattedUserId) {
    return fireStoreService.getMessages(currentUserId, chattedUserId);
  }

  Future<bool> saveMessages(MessageModel savedMessage) async {
    return await fireStoreService.saveMessages(savedMessage);
  }


  

  Future<List<ConversationModel>> getAllConversations(String userId) async {
    DateTime currentTime = await fireStoreService.showTime(userId);
    var conversationList = await fireStoreService.getAllConversations(userId);
    //konusmaModel sınıfımda kullanıcının username ve profilUrl değerini tutmadığım için, bu değerleri userModel sınıfından alıp kullanmaya çalışaçağım.bu nedenle yukarıda her yerden erişebileceğim tumKullanicilarListesi  listesini olusturdum.daha sonra userModeldeki bu verileri konusmaModele atayarak verileri istediğim verilere erişim sağladım.aşagıda  intarnete çıkmadan ve çıkarak ortamın durumuna göre verilere erişim sağlanıyor.//
    for (var currentConversation in conversationList) {
      var userInList =
          findUserInList(currentConversation.talkingTo);

      debugPrint("VERİLER VERİTABANINDAN  OKUNDU");
      var userFetchedFromDatabase =
          await fireStoreService.readUser(currentConversation.talkingTo);
      currentConversation.talkingToUserName = userFetchedFromDatabase.userName;
      currentConversation.talkingToUserProfileUrl = userFetchedFromDatabase.profileUrl;
      calculateTimeAgo(currentConversation, currentTime);
    }
    return conversationList;
  }

  void calculateTimeAgo(ConversationModel currentConversation, DateTime time) {
    currentConversation.lastReadTime = time;
    var duration = time.difference(currentConversation.createdAt.toDate());
    currentConversation.timeDifference = timeago.format(time.subtract(duration));
  }

  UserModel? findUserInList(String userId) {
    // tüm elemanları gezerken ki userId ile kullanıcının userIdsi eşitse  bilgilerini getir.
    for (int i = 0; i < allPersonList.length; i++) {
      if (allPersonList[i].userId == userId) {
        return allPersonList[i];
      }
    }
    return null;
  }


  Future<bool> chatDelete(
      String currentUserId, String chattedUserId) async {
    return await fireStoreService.chatDelete(currentUserId, chattedUserId);
  }

  @override
  Future<bool> deleteUser() async {
    try {
      // Get current user
      UserModel? user = await currentUser();
      if (user == null) return false;

      // Delete user data from Firestore
      await fireStoreService.deleteUserData(user.userId);

      // Delete user from Firebase Auth
      bool authResult = await firebaseAuthService.deleteUser();
      if (!authResult) return false;

      return true;
    } catch (e) {
      debugPrint("Delete user error in Repository: $e");
      return false;
    }
  }
}