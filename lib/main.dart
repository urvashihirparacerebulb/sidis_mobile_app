import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_projects/theme/theme_service.dart';
import 'package:my_projects/utility/constants.dart';
import '../utility/common_methods.dart';
import 'controllers/app_binding/app_binding_controllers.dart';
import 'controllers/general_controller.dart';
import 'modules/dashboard/dashboard_view.dart';
import 'modules/login/login_screen.dart';
import 'modules/splash_screen.dart';
import 'utility/common_methods.dart';

final getPreferences = GetStorage();

pref() async {
  await GetStorage.init();
}

void main() {
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
        Get.off(() => const DashboardView());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
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
