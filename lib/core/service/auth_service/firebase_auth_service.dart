import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/core/service/auth_service/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel?> currentUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      debugPrint("Firebase Auth current user: ${user?.toString()}");
      if (user != null) {
        return _userFromFirebase(user);
      }
      debugPrint("No current user in Firebase Auth");
      return null;
    } catch (e) {
      debugPrint("Current user error in FirebaseAuthService: $e");
      return null;
    }
  }

  UserModel? _userFromFirebase(User user) {
    debugPrint("Creating UserModel from Firebase user: ${user.toString()}");
    return UserModel(
      userId: user.uid,
      email: user.email.toString(),
    );
  }

  @override
  Future<UserModel?> singInAnonymously() async {
    try {
      var userCredential = await firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user!);
    } catch (e) {
      debugPrint("SingInAnonymously Giriş Hatası$e");
      return null;
    }
  }

  @override
  Future<bool> singOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint(" Sign Out Hatası $e");
    }
    return false;
  }

  @override
  Future<UserModel?> googleWithSingIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          return _userFromFirebase(user);
        }
      } else {
        return null;
      }

      return null;
    } catch (e) {
      debugPrint('Google ile Giriş Hatası: $e');
      return null;
    }
  }


  @override
  Future<UserModel?> createUserWithSingIn(String email, String password) async {
    var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredential.user!);
  }


  @override
  Future<UserModel?> emailAndPasswordWithSingIn(
      String email, String password) async {
    var userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredential.user!);
  }


  @override
  Future<bool> deleteUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        await user.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Delete user error in FirebaseAuthService: $e");
      return false;
    }
  }
}
