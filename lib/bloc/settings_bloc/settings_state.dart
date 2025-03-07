part of 'settings_bloc.dart';

enum SettingsStatus { init, loading, success, error }

class SettingsState extends Equatable {
  final SettingsStatus status;

  const SettingsState({
    required this.status,
  });

  SettingsState copyWith({
    SettingsStatus? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
