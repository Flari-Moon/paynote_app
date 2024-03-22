import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:paynote_app/services/RequestService.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:stacked_services/stacked_services.dart';
import 'SharedPrefService.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static NavigationService _navigationService = locator<NavigationService>();
  static User user;
  static RequestService requestService = locator<RequestService>();
  static SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  static serializeAndNavigate(RemoteMessage message, bool closed) {
    SharedPref().remove('buffer');
    SharedPref().remove('transactionList');
    // SharedPref().remove('accounts');
    SharedPref().remove('subscriptionList');
    var notificationData = message.notification;
    bool userLoggedIn = SharedPref().getBool('userLoggedIn');
    SharedPref().setBool("updateAccountNeeded", true);
    if (message.data['screen'] == 'dashboard') {
      if (!closed) {
        user = _sharedPrefService.loadProfileUser();
        if (userLoggedIn && userLoggedIn != null) {
          _navigationService.clearStackAndShow(Routes.dashboardView,
              arguments: DashboardViewArguments(user: user));
        } else {
          _navigationService.clearStackAndShow(Routes.phoneVerificationView,
              arguments: PhoneVerificationViewArguments(
                  title: 'Get started with Paynote',
                  subTitle:
                      'Please confirm your country code. Paynote will send a code to verify your phone number'));
        }
      }
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print("Handling a background message: ${message.messageId}");
    await Firebase.initializeApp();
    await SharedPref().init();
    serializeAndNavigate(message, true);
  }

  Future initialize() async {
    //user = requestService.loadProfileUser();
    AndroidInitializationSettings initializationSettingsand =
        AndroidInitializationSettings('ic_stat_name');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var initializationSettings =
        InitializationSettings(android: initializationSettingsand);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
                // other properties...
              ),
            ));
      }
      serializeAndNavigate(message, false);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message also contained a notification: ${message.notification}');
      serializeAndNavigate(message, false);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _firebaseMessaging.getToken().then((token) {
      print(token);
      SharedPref()
          .setString('firebaseToken', token); // Print the Token in Console
    });
    _firebaseMessaging.subscribeToTopic('all');
  }
}
