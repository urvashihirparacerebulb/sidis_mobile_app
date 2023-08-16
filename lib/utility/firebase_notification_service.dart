import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  // Future<void> _isAndroidPermissionGranted() async {
  //   if (Platform.isAndroid) {
  //     final bool granted = await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //         ?.areNotificationsEnabled() ??
  //         false;
  //      _notificationsEnabled = granted;
  //   }
  // }
  //
  // Future<void> _requestPermissions() async {
  //   if (Platform.isIOS || Platform.isMacOS) {
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         IOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //         MacOSFlutterLocalNotificationsPlugin>()
  //         ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //   } else if (Platform.isAndroid) {
  //     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
  //     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>();
  //
  //     final bool? granted = await androidImplementation?.requestPermission();
  //       _notificationsEnabled = granted ?? false;
  //   }
  // }

  static initializeService() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("notification.......................");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        PushNotificationModel model = PushNotificationModel();
        model.title = message.notification!.title;
        model.body = message.notification!.body;
        showNotification(model);
      } else {
        PushNotificationModel model = PushNotificationModel();
        model.title = message.data["title"];
        model.body = message.data["body"];
        showNotification(model);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      ///Handle tap here event.data["id"]
    });
    firebaseMessaging.requestPermission(sound: true, badge: true, alert: true, provisional: true);
    // final ttoken = getFcmToken();
    // if (!isNotEmptyString(getFcmToken())) {
    //   print("FCM-TOKEN NULL");

    firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM-TOKEN $token");
      // setFcmToken(token!);
    });
    // }
  }

  static showNotification(PushNotificationModel data) async {
    print(data);
    var android = const AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    var jsonData = jsonEncode(data);
    await flutterLocalNotificationsPlugin.show(DateTime.now().millisecond, data.title, data.body, platform, payload: jsonData);
  }
}

class PushNotificationModel {
  PushNotificationModel({
    this.title,
    this.body,
  });

  String? title;
  String? body;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      PushNotificationModel(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
  };
}
