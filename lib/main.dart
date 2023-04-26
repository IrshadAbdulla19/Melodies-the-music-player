import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_player/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userIn = 'for show';
const userCheck = 'for check';
void main() {
  runApp(MyApp());
  SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
