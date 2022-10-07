//import 'package:dashui/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/data_controller.dart';
import 'controllers/navigator_controller.dart';
import 'screens/auth/authenticate_screen.dart';
import 'services/db_helper.dart';
import 'services/native_db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDbLibrary();
  await DbHelper.initDb();
  await NativeDbHelper.initDb();
  Get.put(NavigatorController());
  Get.put(DataController());
  Get.put(AuthController());
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 30.0
    ..radius = 5.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'zando graphics app by G-Numerics',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Didact Gothic',
      ),
      home: Builder(
        builder: (context) {
          return const AuthenticateScreen();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}