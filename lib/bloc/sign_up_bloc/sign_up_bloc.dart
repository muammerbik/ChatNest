import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final repository = locator<Repository>();

  SignUpBloc()
      : super(SignUpState(
          allUserList: [],
          status: SignUpStatus.init,
          userModel: UserModel(email: "", userId: ""),
        )) {
    on<SignUpStartEvent>(onSignUpStartEvent);
    on<CurrentUserStartEvent>(currentUserEvent);
  }

  Future<UserModel?> onSignUpStartEvent(
      SignUpStartEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(
        state.copyWith(status: SignUpStatus.loading),
      );

      final userModel =
          await repository.createUserWithSingIn(event.email, event.password);

      if (userModel != null) {
        emit(state.copyWith(
          status: SignUpStatus.success,
          userModel: userModel,
        ));
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("SignUp Error: $e");
    }
    return null;
    //Hata çıkarsa <UserModel?>i voide çevir ve return null 'ı kaldır.
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }

  Future<void> currentUserEvent(
      CurrentUserStartEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(
        state.copyWith(status: SignUpStatus.loading),
      );

      final userModel = await repository.currentUser();
      if (userModel != null) {
        emit(state.copyWith(
          status: SignUpStatus.success,
          userModel: userModel,
        ));
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("Current User Hatası: $e");
    }
  }
}
