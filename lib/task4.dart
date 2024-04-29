import 'package:flutter/material.dart';

class Task4 extends StatelessWidget {
  static const String routeName = "Task4";

  const Task4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Container(
        child: Center(
          child: Text(
            "Task 4",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
