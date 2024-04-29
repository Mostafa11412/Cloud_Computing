import 'package:flutter/material.dart';

class Task3 extends StatelessWidget {
  static const String routeName = "Task3";

  const Task3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Container(
        child: Center(
          child: Text(
            "Task 3",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
