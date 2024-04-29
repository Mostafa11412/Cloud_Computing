import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Task1 extends StatefulWidget {
  static const String routeName = "Task1";
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  List<QueryDocumentSnapshot> data = [];

  @override
  void initState() {
    FirebaseMessaging.instance.subscribeToTopic("LAB");

    FirebaseMessaging.onMessage.listen(foregroundNotificationHandler);

    getToken();
    readNotification();
    super.initState();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("==================================");
    print("TOKEN : $token");
  }

  void foregroundNotificationHandler(RemoteMessage message) async {
    if (message.notification != null) {
      CollectionReference Notifications =
          FirebaseFirestore.instance.collection("Notifications");

      await Notifications.add({
        "Date Time": message.sentTime.toString(),
        "title": message.notification!.title,
        "body": message.notification!.body,
        "key": message.data['key-test'] ?? null,
      });
    }
  }

  readNotification() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('Notifications').get();
    data = [];
    data.addAll(qs.docs);

    setState(() {});
  }

  Future<dynamic> refresh() async {
    readNotification();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
            style: TextStyle(fontSize: 40),
          ),
          centerTitle: true,
          actions: [
            ElevatedButton(onPressed: refresh, child: Icon(Icons.refresh)),
          ],
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Card(
              child: Column(
                children: [
                  Text(
                    '''          Data/Time :
${data[i]['Date Time']}''',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Title : ${data[i]['title']}",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Body : ${data[i]['body']}",
                    style: TextStyle(fontSize: 30),
                  ),
                  data[i]['key'] == null
                      ? Text('')
                      : Text(
                          "Key : ${data[i]['key']}",
                          style: TextStyle(fontSize: 30),
                        )
                ],
              ),
            );
          },
        ));
  }
}
