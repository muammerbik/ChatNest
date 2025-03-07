import 'package:chat_menager/core/service/auth_service/firebase_auth_service.dart';
import 'package:chat_menager/core/service/firestore_service/firestore_services.dart';
import 'package:chat_menager/core/service/storage_service/storage_services.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setupGetIt() {
  locator.registerLazySingleton<Repository>(
    () => Repository(),
  );
  locator.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );
  locator.registerLazySingleton<FirestoreServices>(
    () => FirestoreServices(),
  );
  locator.registerLazySingleton<FirebaseStorageService>(
    () => FirebaseStorageService(),
  );
}
