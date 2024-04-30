import 'package:cloud_computing/firebase/firebase_functions.dart';
import 'package:cloud_computing/models/url_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Task4 extends StatelessWidget {
  static const String routeName = "Task4";

  const Task4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 4"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFunctions.getUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            List<UrlModel> urlsList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            print(urlsList[0].id);
            if (urlsList.isEmpty) {
              return Text("No Data");
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      extentRatio: 0.4,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            print(urlsList[index].id);
                            //print(urlsList[index].id!);
                            FirebaseFunctions.deleteUrl(urlsList[index].id);
                          },
                          backgroundColor: Colors.red,
                          label: "Delete",
                          icon: Icons.delete,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                        )
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(12),
                    child: Text(urlsList[index].url ?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 30,
                color: Colors.black,
              ),
              itemCount: urlsList.length,
            );
          },
        ),
      ),
    );
  }
}
