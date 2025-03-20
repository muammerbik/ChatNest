import 'dart:io';
import 'package:chat_menager/core/service/storage_service/storage_base.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements FireBaseStorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadFile(String userId, String fileType, File fileToUpload) async {
    Reference reference = _firebaseStorage
        .ref()
        .child(userId)
        .child(fileType)
        .child("profil_photo.png");
    UploadTask uploadTask = reference.putFile(fileToUpload);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
