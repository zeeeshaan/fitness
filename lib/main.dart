import 'package:fitness/view/login/on_boarding_view.dart';
import 'package:fitness/view/menu/menu_view.dart';
import 'package:fitness/view/splash.dart';
import 'package:flutter/material.dart';

import 'common/color_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}

