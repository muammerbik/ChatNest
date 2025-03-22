part of 'sign_up_bloc.dart';

enum SignUpStatus { init, loading, success, error }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final UserModel userModel;
  final File? imageFile;

  const SignUpState({
    required this.status,
    required this.userModel,
    this.imageFile,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    UserModel? userModel,
    File? imageFile,
  }) {
    return SignUpState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [status, userModel, imageFile];
}
