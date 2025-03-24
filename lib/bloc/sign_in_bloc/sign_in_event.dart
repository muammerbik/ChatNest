// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInStartEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInStartEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GoogleSignInEvent extends SignInEvent {}

class ResetPasswordEvent extends SignInEvent {
  final String email;
  const ResetPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
