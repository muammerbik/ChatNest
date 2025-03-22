part of 'sign_in_bloc.dart';

enum SignInStatus { init, loading, success, error }

class SignInState extends Equatable {
  final SignInStatus status;
  final UserModel userModel;

  const SignInState({
    required this.status,
    required this.userModel,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  });

  SignInState copyWith({
    SignInStatus? status,
    UserModel? userModel,
  }) {
    return SignInState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [
        status,
        userModel,
      ];
}
