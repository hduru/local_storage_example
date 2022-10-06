import 'package:local_storage_example/models/user.dart';
import 'package:local_storage_example/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements LocalStorageService {
  late final SharedPreferences storage;

  SharedPreferencesService() {
    init();
  }

  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
  }

  @override
  Future<User> getUserInformation() async {
    String email = storage.getString("email") ?? '';
    String password = storage.getString("password") ?? '';
    bool rememberMe = storage.getBool("rememberMe") ?? false;

    return User(email: email, rememberMe: rememberMe, password: password);
  }

  @override
  Future<void> saveUserInformation(User u) async {
    storage.setString("email", u.email);
    storage.setString("password", u.password);
    storage.setBool("rememberMe", u.rememberMe);
  }

  @override
  Future<void> deleteStorageValue(String key) async {
    await storage.remove(key);
  }
}
