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

class PickImageFromGalleryEvent extends SignUpEvent {}

class PickImageFromCameraEvent extends SignUpEvent {}

class CropImageEvent extends SignUpEvent {
  final File imageFile;
  const CropImageEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class UpdateUserNameEvent extends SignUpEvent {
  final String userId;
  final String newUserName;

  const UpdateUserNameEvent({
    required this.userId,
    required this.newUserName,
  });

  @override
  List<Object> get props => [userId, newUserName];
}

class UpdateSurnameEvent extends SignUpEvent {
  final String userId;
  final String newSurname;

  const UpdateSurnameEvent({required this.userId, required this.newSurname});
  @override
  List<Object> get props => [userId, newSurname];
}

class UploadFileEvent extends SignUpEvent {
  final String userId;
  final String fileType;
  final File profilePhoto;

  const UploadFileEvent({
    required this.userId,
    required this.fileType,
    required this.profilePhoto,
  });

  @override
  List<Object> get props => [userId, fileType, profilePhoto];
}
