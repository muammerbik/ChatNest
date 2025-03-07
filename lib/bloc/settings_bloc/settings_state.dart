part of 'settings_bloc.dart';

enum SettingsStatus { init, loading, success, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final UserModel userModel;

  const SettingsState({required this.status, required this.userModel});

  SettingsState copyWith({SettingsStatus? status, UserModel? userModel}) {
    return SettingsState(
        status: status ?? this.status, userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [status, userModel];
}
