import 'package:cloud_computing/home.dart';
import 'package:cloud_computing/tasks/task1&2.dart';
import 'package:cloud_computing/firebase/firebase_options.dart';
import 'package:cloud_computing/tasks/task3.dart';
import 'package:cloud_computing/tasks/task4.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> BackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  CollectionReference Notifications =
      FirebaseFirestore.instance.collection("Notifications");

  if (message.notification != null) {
    await Notifications.add({
      "Date Time": message.sentTime.toString(),
      "title": message.notification!.title,
      "body": message.notification!.body,
      "key": message.data['key-test'] ?? null,
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(BackgroundMessageHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))),
        debugShowCheckedModeBanner: false,
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (context) => Home(),
          Task1.routeName: (context) => Task1(),
          Task3.routeName: (context) => Task3(),
          Task4.routeName: (context) => Task4(),
        });
  }
}
