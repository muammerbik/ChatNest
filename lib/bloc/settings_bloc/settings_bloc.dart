import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final repository = locator<Repository>();
  SettingsBloc() : super(SettingsState(status: SettingsStatus.init)) {
    on<SignOutEvent>(settingsSignOut);
  }

  Future<void> settingsSignOut(
      SignOutEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(
        state.copyWith(status: SettingsStatus.loading),
      );

      final result = await repository.singOut();
      if (result) {
        emit(
          state.copyWith(status: SettingsStatus.success),
        );
      } else {
        emit(
          state.copyWith(status: SettingsStatus.error),
        );
        debugPrint("Çıkış yapılırken bir hata oluştu");
      }
    } catch (e) {
      emit(
        state.copyWith(status: SettingsStatus.error),
      );
      debugPrint("Çıkış yapılırken bir hata oluştu: $e");
    }
  }
}
