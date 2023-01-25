import 'package:flutter/material.dart';
import 'package:flutter_todo_todo/database/database_helper.dart';
import 'package:flutter_todo_todo/services/theme_service.dart';
import 'package:flutter_todo_todo/theme/theme.dart';
import 'package:flutter_todo_todo/ui/home_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter todo application',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
