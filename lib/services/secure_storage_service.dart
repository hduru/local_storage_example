import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage_example/models/user.dart';
import 'package:local_storage_example/services/local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage storage;

  SecureStorageService() {
    storage = const FlutterSecureStorage();
  }

  @override
  Future<User> getUserInformation() async {
    String email = await storage.read(key: "email") ?? '';
    String password = await storage.read(key: "password") ?? '';
    String remember = await storage.read(key: "rememberMe") ?? 'false';
    bool rememberMe = remember.toLowerCase() == 'true' ? true : false;

    return User(email: email, rememberMe: rememberMe, password: password);
  }

  @override
  Future<void> saveUserInformation(User u) async {
    await storage.write(key: "email", value: u.email);
    await storage.write(key: "password", value: u.password);
    await storage.write(key: "rememberMe", value: u.rememberMe.toString());
  }

  @override
  Future<void> deleteStorageValue(String key) async {
    await storage.delete(key: key);
  }
}
