import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final repository = locator<Repository>();
  final ImagePicker _picker = ImagePicker();

  SignUpBloc()
      : super(SignUpState(
          allUserList: [],
          status: SignUpStatus.init,
          userModel: UserModel(email: "", userId: ""),
        )) {
    on<SignUpStartEvent>(onSignUpStartEvent);
    on<CurrentUserStartEvent>(currentUserEvent);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<PickImageFromCameraEvent>(_onPickImageFromCamera);
    on<CropImageEvent>(_onCropImage);
    on<UpdateUserNameEvent>(_onUpdateUserName);
    on<UploadFileEvent>(_onUploadFile);
  }

  Future<UserModel?> onSignUpStartEvent(
      SignUpStartEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(
        state.copyWith(status: SignUpStatus.loading),
      );

      final userModel =
          await repository.createUserWithSingIn(event.email, event.password);

      if (userModel != null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            userModel: userModel,
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("SignUp Error: $e");
    }
    return null;
    //Hata çıkarsa <UserModel?>i voide çevir ve return null 'ı kaldır.
  }

  Future<void> currentUserEvent(
      CurrentUserStartEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(
        state.copyWith(status: SignUpStatus.loading),
      );

      final userModel = await repository.currentUser();
      debugPrint("Current user from repository: ${userModel?.toString()}");
      if (userModel != null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            userModel: userModel,
          ),
        );
        debugPrint("SignUpBloc state updated with user: ${state.userModel.toString()}");
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
        debugPrint("Failed to get current user - userModel is null");
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("Current User Error: $e");
    }
  }

  Future<void> _onPickImageFromGallery(
    PickImageFromGalleryEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile != null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            imageFile: File(pickedFile.path),
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.init),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
    }
  }

  Future<void> _onPickImageFromCamera(
    PickImageFromCameraEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      final pickedFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedFile != null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            imageFile: File(pickedFile.path),
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.init),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
    }
  }

  Future<void> _onCropImage(
    CropImageEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: event.imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9,
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: "Image Cropper",
          ),
        ],
      );

      if (croppedFile != null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            imageFile: File(croppedFile.path),
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.init),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
    }
  }

  Future<void> _onUpdateUserName(
    UpdateUserNameEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      final isUpdated = await repository.updateUserName(
        event.userId,
        event.newUserName,
      );

      if (isUpdated) {
        // Kullanıcı adı güncellendi, state'i güncelle
        final updatedUserModel = state.userModel.copyWith(
          userName: event.newUserName,
        );
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            userModel: updatedUserModel,
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("Update User Name Error: $e");
    }
  }

  Future<void> _onUploadFile(
    UploadFileEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      final fileUrl = await repository.uploadFile(
        event.userId,
        event.fileType,
        event.profilePhoto,
      );
      if (fileUrl.isNotEmpty) {
        // Dosya başarıyla yüklendi, state'i güncelle
        final updatedUserModel = state.userModel.copyWith(
          profileUrl: fileUrl,
        );
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            userModel: updatedUserModel,
          ),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: SignUpStatus.error),
      );
      debugPrint("Upload File Error: $e");
    }
  }
}
