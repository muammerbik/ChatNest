part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SignOutEvent extends SettingsEvent {}

class DeleteUserEvent extends SettingsEvent {}
