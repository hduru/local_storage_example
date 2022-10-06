import 'package:local_storage_example/models/user.dart';

abstract class LocalStorageService {
  Future<void> saveUserInformation(User user);
  Future<User> getUserInformation();
  Future<void> deleteStorageValue(String key);
}
