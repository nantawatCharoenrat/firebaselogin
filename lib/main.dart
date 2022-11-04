import 'package:firebaselogin/User_page.dart';
import 'package:firebaselogin/Frame.dart';
import 'package:firebaselogin/addcat2.dart';
import 'package:firebaselogin/addcat3.dart';
import 'package:firebaselogin/cash.dart';
import 'package:firebaselogin/cat3.dart';
import 'package:firebaselogin/confirm.dart';
import 'package:firebaselogin/home.dart';
import 'package:flutter/material.dart';
import 'package:firebaselogin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/register.dart';
import 'package:firebaselogin/addcat1.dart';
import 'package:firebaselogin/cat1.dart';
import 'package:firebaselogin/cat2.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/mainframe': (context) => MyStatefulWidget(),
        '/User_page': (context) => Userpage(),
        '/catpage1': (context) => Catpage1(),
        '/catpage2': (context) => Catpage2(),
        '/catpage3': (context) => Catpage3(),
        '/addcat1': (context) => AddCatPage1(),
        '/addcat2': (context) => AddCatPage2(),
        '/addcat3': (context) => AddCatPage3(),
        '/home': (context) => Cat_view(),
        '/cash': (context) => Cash(),
        '/confirm': (context) => Confirm(),
      },
    );
  }
}
