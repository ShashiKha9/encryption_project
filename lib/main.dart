import 'package:encryption_project/model/login.dart';
import 'package:encryption_project/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Hive.initFlutter();
  Hive.registerAdapter(LoginAdapter());
   await Hive.openBox<Login>("login");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenPage(),
    );
  }
}
