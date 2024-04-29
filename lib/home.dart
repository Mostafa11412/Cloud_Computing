import 'package:cloud_computing/task1&2.dart';
import 'package:cloud_computing/task3.dart';
import 'package:cloud_computing/task4.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String routeName = "Home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[300]),
              child: ListTile(
                title: Text(
                  "Task 1&2",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Task1.routeName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[300]),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Task3.routeName);
                },
                title: Text(
                  "Task 3",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Task4.routeName);
                },
                title: Text(
                  "Task 4",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ),
    );
    
  }
}
