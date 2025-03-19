import 'package:chat_menager/core/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel?> currentUser();
  Future<UserModel?> singInAnonymously();
  Future<bool> singOut();
  Future<UserModel?> googleWithSingIn();
  Future<UserModel?> createUserWithSingIn(String email, String password);
  Future<UserModel?> emailAndPasswordWithSingIn(String email, String password);
  Future<bool> deleteUser();
}
