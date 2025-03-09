part of 'sign_up_bloc.dart';

enum SignUpStatus { init, loading, success, error }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final List<UserModel> allUserList;
  final UserModel userModel;
  final File? imageFile;

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignUpState({
    required this.status,
    required this.allUserList,
    required this.userModel,
    this.imageFile,
    TextEditingController? nameController,
    TextEditingController? surnameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : nameController = nameController ?? TextEditingController(),
        surnameController = surnameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  SignUpState copyWith({
    SignUpStatus? status,
    List<UserModel>? allUserList,
    UserModel? userModel,
    File? imageFile,
    TextEditingController? nameController,
    TextEditingController? surnameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return SignUpState(
      status: status ?? this.status,
      allUserList: allUserList ?? this.allUserList,
      userModel: userModel ?? this.userModel,
      imageFile: imageFile ?? this.imageFile,
      nameController: nameController ?? this.nameController,
      surnameController: surnameController ?? this.surnameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allUserList,
        userModel,
        imageFile,
        nameController,
        surnameController,
        emailController,
        passwordController,
      ];
}
