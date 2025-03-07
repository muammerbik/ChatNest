part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpStartEvent extends SignUpEvent {
  final String name;
  final String surname;
  final String email;
  final String password;

  const SignUpStartEvent(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [name, surname, email, password];
}

class CurrentUserStartEvent extends SignUpEvent {}
