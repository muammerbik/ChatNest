import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/core/service/firestore_service/db_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices implements DbBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel userModel) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.doc("users/${userModel.userId}").get();
      if (documentSnapshot.data() == null) {
        Map<String, dynamic> userData = {
          ...userModel.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        
        await firestore
            .collection("users")
            .doc(userModel.userId)
            .set(userData);
        return true;
      } else {
        // Update existing user data
        Map<String, dynamic> userData = {
          ...userModel.toMap(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        
        await firestore
            .collection("users")
            .doc(userModel.userId)
            .update(userData);
        return true;
      }
    } catch (e) {
      debugPrint("Save user error in FirestoreServices: $e");
      return false;
    }
  }

  @override
  Future<UserModel> readUser(String userId) async {
    DocumentSnapshot readUsers =
        await firestore.collection("users").doc(userId).get();
    Map<String, dynamic>? readUserInfoMap =
        readUsers.data() as Map<String, dynamic>?;
    UserModel readUserObject = UserModel.fromMap(readUserInfoMap!);
    debugPrint("okunan user nesnesi$readUserObject");
    return readUserObject;
  }


  @override
  Future<bool> updateUserName(String userId, String newUserName) async {
    try {
      await firestore
          .collection("users")
          .doc(userId)
          .update({"userName": newUserName});
      return true;
    } catch (e) {
      debugPrint("Update username error: $e");
      return false;
    }
  }

  Future<bool> updateSurname(String userId, String newSurname) async {
    try {
      await firestore
          .collection("users")
          .doc(userId)
          .update({"surname": newSurname});
      return true;
    } catch (e) {
      debugPrint("Update surname error: $e");
      return false;
    }
  }


  @override
  Future<bool> updateProfilePhoto(String userId, String profilePhotoUrl) async {
    await firestore
        .collection("users")
        .doc(userId)
        .update({"profileUrl": profilePhotoUrl});
    return true;
  }


  @override
  Future<List<ConversationModel>> getAllConversations(String userId) async {
    debugPrint("Fetching conversations for user: $userId");
    
    QuerySnapshot querySnapshot = await firestore
        .collection("conversations")
        .where("conversationOwner", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .get();

    debugPrint("Found ${querySnapshot.docs.length} conversations");

    List<ConversationModel> conversationsList = [];

    for (DocumentSnapshot talkUser in querySnapshot.docs) {
      var data = talkUser.data();
      debugPrint("Processing conversation data: $data");
      if (data is Map<String, dynamic>) {
        try {
          ConversationModel talkUser = ConversationModel.fromMap(data);
          conversationsList.add(talkUser);
          debugPrint("Successfully added conversation: ${talkUser.toString()}");
        } catch (e) {
          debugPrint("Error parsing conversation data: $e");
        }
      }
    }
    debugPrint("Returning ${conversationsList.length} conversations");
    return conversationsList;
  }


  @override
  Stream<List<MessageModel>> getMessages(String currentUserId, String chattedUserId) {
    var snapshot = firestore
        .collection("conversations")
        .doc("$currentUserId--$chattedUserId")
        .collection("messages")
        .orderBy("timestamp")
        .snapshots();
    return snapshot.map(
      (snapshot) => snapshot.docs
          .map(
            (event) => MessageModel.fromMap(
              event.data(),
            ),
          )
          .toList(),
    );
  }


  @override
  Future<bool> saveMessages(MessageModel savedMessage) async {
    var messageId = firestore.collection("conversations").doc().id;
    var myDocumentId = "${savedMessage.sender}--${savedMessage.receiver}";
    var receiverDocumentId = "${savedMessage.receiver}--${savedMessage.sender}";
    var idMapToSave = savedMessage.toMap();

    await firestore
        .collection("conversations")
        .doc(myDocumentId)
        .collection("messages")
        .doc(messageId)
        .set(idMapToSave);
      
    idMapToSave.update("isSentByMe", (value) => false);

    await firestore
        .collection("conversations")
        .doc(receiverDocumentId)
        .collection("messages")
        .doc(messageId)
        .set(idMapToSave);
    
    await firestore.collection("conversations").doc(myDocumentId).set({
      "conversationOwner": savedMessage.sender,
      "talkingTo": savedMessage.receiver,
      "lastSentMessage": savedMessage.content,
      "isRead": false,
      "createdAt": FieldValue.serverTimestamp(),
      
    });

    await firestore.collection("conversations").doc(receiverDocumentId).set({
      "conversationOwner": savedMessage.receiver,
      "talkingTo": savedMessage.sender,
      "lastSentMessage": savedMessage.content,
      "isRead": false,
      "createdAt": FieldValue.serverTimestamp(),
     
    });

    return true;
  }


  @override
  Future<List<UserModel>> getUserWithPagination(UserModel? lastFetchedUser, int numberOfElementsToFetch) async {
    QuerySnapshot querySnapshot;
    List<UserModel> allUserList = [];
    if (lastFetchedUser == null) {
      debugPrint("ilk defa kullanıcılar getirliliyor");
      querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("createdAt", descending: true)
          .limit(numberOfElementsToFetch)
          .get();
    } else {
      debugPrint("Sonraki kullanıcılar getirliliyor");
      querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("createdAt", descending: true)
          .startAfter([lastFetchedUser.createdAt])
          .limit(numberOfElementsToFetch)
          .get();
      await Future.delayed(
        const Duration(seconds: 1),
      );
    }
    for (DocumentSnapshot snap in querySnapshot.docs) {
      var data = snap.data();
      if (data is Map<String, dynamic>) {
        UserModel singleUser = UserModel.fromMap(data);
        allUserList.add(singleUser);
        debugPrint("getirilien user name ${singleUser.userName!}");
      }
    }
    return allUserList;
  }


  @override
  Future<DateTime> showTime(String userId) async {
    await firestore
        .collection("server")
        .doc(userId)
        .set({"saat": FieldValue.serverTimestamp()});
    var readToMap = await firestore.collection("server").doc(userId).get();
    Map<String, dynamic>? data = readToMap.data();
    if (data != null) {
      Timestamp readDate = data["saat"];
      return readDate.toDate();
    } else {
      throw Exception("Data not found");
    }
  }


  @override
  Future<bool> chatDelete(String currentUserId, String chattedUserId) async {
    String chatId = "$currentUserId--$chattedUserId";
    String reverseChatId = "$chattedUserId--$currentUserId";

    try {
      // Konuşmayı sil
      await firestore.collection("conversations").doc(chatId).delete();
      await firestore.collection("conversations").doc(reverseChatId).delete();

      // Mesajları sil
      var messagesSnapshot = await firestore
          .collection("conversations")
          .doc(chatId)
          .collection("messages")
          .get();
      for (var doc in messagesSnapshot.docs) {
        await doc.reference.delete();
      }

      return true;
    } catch (e) {
      debugPrint("Sohbet silme hatası: $e");
      return false;
    }
  }


  Future<void> deleteUserData(String userId) async {
    try {
      // Delete user's profile data
      await firestore.collection("users").doc(userId).delete();

      // Delete user's conversations
      var conversationsSnapshot = await firestore
          .collection("conversations")
          .where("conversationOwner", isEqualTo: userId)
          .get();

      for (var doc in conversationsSnapshot.docs) {
        String chatId = doc.id;
        
        // Delete messages in the conversation
        var messagesSnapshot = await firestore
            .collection("conversations")
            .doc(chatId)
            .collection("messages")
            .get();
            
        for (var messageDoc in messagesSnapshot.docs) {
          await messageDoc.reference.delete();
        }

        // Delete the conversation document
        await doc.reference.delete();
      }

      // Delete conversations where user is the recipient
      var recipientConversationsSnapshot = await firestore
          .collection("conversations")
          .where("talkingTo", isEqualTo: userId)
          .get();

      for (var doc in recipientConversationsSnapshot.docs) {
        String chatId = doc.id;
        
        // Delete messages in the conversation
        var messagesSnapshot = await firestore
            .collection("conversations")
            .doc(chatId)
            .collection("messages")
            .get();
            
        for (var messageDoc in messagesSnapshot.docs) {
          await messageDoc.reference.delete();
        }

        // Delete the conversation document
        await doc.reference.delete();
      }
    } catch (e) {
      debugPrint("Delete user data error in FirestoreServices: $e");
      throw e;
    }
  }
}