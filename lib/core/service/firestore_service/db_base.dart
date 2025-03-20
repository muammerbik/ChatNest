
import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';

abstract class DbBase {
  Future<bool> saveUser(UserModel userModel);
  Future<UserModel> readUser(String userId);
  Future<bool> updateUserName(String userId, String newUserName);
  Future<bool> updateProfilePhoto(String userId, String profilePhotoUrl);
  Future<List<UserModel>> getUserWithPagination(UserModel lastFetchedUser, int numberOfElementsToFetch);
  Stream<List<MessageModel>> getMessages(String currentUserId, String chattedUserId);
  Future<bool> saveMessages(MessageModel savedMessage);
  Future<List<ConversationModel>> getAllConversations(String userId);
  Future<DateTime> showTime(String userId);
  Future<bool> chatDelete(String currentUserId, String chattedUserId);
}