import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:putty/const.dart';
import 'package:putty/firebase/messaging.dart';
import 'package:putty/routes/home/home.dart';
import 'package:firebase_core/firebase_core.dart';

/* FCM Initialization */

/// Initialize the [FlutterLocalNotificationsPlugin] package for heads up FCM.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/* AMC Initialization */

/// [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/* Firebase Messaging Functions */

/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Firebase Initialiazation

_initFirebase() async {
  try {
    await Firebase.initializeApp(); // Initializes Application
    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler); //Initializes Messaging Platform

    if (USE_FIRESTORE_EMULATOR) {
      FirebaseFirestore.instance.settings = const Settings(
          host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
    }
  } catch (e) {}
}

_initNotifications() async {
  try {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } catch (e) {}
}

/* Runner Function */
bool USE_FIRESTORE_EMULATOR = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  _initFirebase().then((_) => runApp(MyApp()));
}

/**   Main Function   **/

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _token;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("Taken message From ${message}");
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
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
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}
