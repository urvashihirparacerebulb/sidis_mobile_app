import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_projects/theme/theme_service.dart';
import 'package:my_projects/utility/constants.dart';
import 'package:my_projects/utility/firebase_notification_service.dart';
import '../utility/common_methods.dart';
import 'controllers/app_binding/app_binding_controllers.dart';
import 'controllers/general_controller.dart';
import 'modules/dashboard/dashboard_listing/common_dashboard.dart';
import 'modules/login/login_screen.dart';
import 'modules/splash_screen.dart';

final getPreferences = GetStorage();

pref() async {
  await GetStorage.init();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref();
  if (readThemePref() == systemDefault) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      ThemeService().saveThemeToBox(true);
    } else {
      ThemeService().saveThemeToBox(false);
    }
  }
  await configureApp();
  runApp(const MyApp()
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),
  );
}

Future<void> configureApp() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SIDIS App',
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode:
      ThemeService().loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 10), () {
      GeneralController.to.isDarkMode.value = ThemeService().loadThemeFromBox();
    });
    Timer(const Duration(seconds: 2), () {
      if (getIsLogin()) {
        Get.off(() => const CommonDashboard());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
    FirebaseNotificationService.initializeService();
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    if (readThemePref() == systemDefault) {
      systemDefaultTheme();
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreenView();
  }
}
