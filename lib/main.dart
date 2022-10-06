import 'package:flutter/material.dart';
import 'package:local_storage_example/services/secure_storage_service.dart';
import 'package:local_storage_example/services/local_storage_service.dart';
import 'package:local_storage_example/services/shared_preferences_service.dart';
import 'package:local_storage_example/ui/login_page.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator.registerSingleton<LocalStorageService>(SecureStorageService());
  //OR
  //locator.registerSingleton<LocalStorageService>(SharedPreferencesService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Login(title: 'Local Storage Demo'),
    );
  }
}
