import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/login/welcome_screen.dart';
import 'modules/splash_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SIDIS App',
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        textTheme: const TextTheme(
            caption: TextStyle(fontFamily: 'Arial',fontSize: 14)),
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Get.off(() => const WelcomeView(), transition: Transition.cupertinoDialog);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreenView();
  }
}
