import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final repository = locator<Repository>();

  SignInBloc()
      : super(
          SignInState(
            status: SignInStatus.init,
            userModel: UserModel(userId: "", email: ""),
          ),
        ) {
    on<SignInStartEvent>(signInStart);
    on<GoogleSignInEvent>(onGoogleSignIn);
  }

  Future<void> signInStart(
      SignInStartEvent event, Emitter<SignInState> emit) async {
    try {
      emit(
        state.copyWith(status: SignInStatus.loading),
      );

      final userModel = await repository.emailAndPasswordWithSingIn(
          event.email, event.password);

      if (userModel != null) {
        emit(
          state.copyWith(
            status: SignInStatus.success,
            userModel: userModel,
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignInStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignInStatus.error),
      );
      debugPrint("SignUp Error: $e");
    }
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }

  Future<void> onGoogleSignIn(
      GoogleSignInEvent event, Emitter<SignInState> emit) async {
    try {
      emit(
        state.copyWith(status: SignInStatus.loading),
      );

      final userModel = await repository.googleWithSingIn();
      if (userModel != null) {
        emit(
          state.copyWith(
            status: SignInStatus.success,
            userModel: userModel,
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignInStatus.error),
        );
        debugPrint("Google ile giriş sırasında bir hata oluştu");
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.error,
        ),
      );
      debugPrint("Google Sign-In Error: $e");
    }
  }
}
