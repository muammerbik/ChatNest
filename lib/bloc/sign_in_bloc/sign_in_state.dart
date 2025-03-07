part of 'sign_in_bloc.dart';

enum SignInStatus { init, loading, success, error }

class SignInState extends Equatable {
  final SignInStatus status;
  final UserModel userModel;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignInState({
    required this.status,
    required this.userModel,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  SignInState copyWith({
    SignInStatus? status,
    UserModel? userModel,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return SignInState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object> get props => [
        status,
        userModel,
      ];

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
