import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Task3 extends StatefulWidget {
  static const String routeName = "Task3";

  Task3({super.key});

  @override
  State<Task3> createState() => _Task3State();
}

class _Task3State extends State<Task3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task 3"),),
      body: Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                uploadFiles();
              },
              child: Text(
                "Upload Files",
                style: TextStyle(fontSize: 30, color: Colors.black),
              )),
        ),
      ),
    );
  }

  Future<void> uploadFiles() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        for (PlatformFile pickedFile in result.files) {
          print(pickedFile.path);
          final ref = await FirebaseStorage.instance
              .ref('Task3_Files/${pickedFile.name}');
          final file = File(pickedFile.path!);
          await ref.putFile(file);
        }
        

        final snackBar = SnackBar(
          content: Text('File Uploaded to FireBase Storage Succefully'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // UrlModel model = UrlModel(url: );
        await saveUrls();
        // FirebaseFunctions.addUrl(model);
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> saveUrls() async {
    CollectionReference filesUrls =
        FirebaseFirestore.instance.collection("filesUrls");


    QuerySnapshot existingUrlsSnapshot = await filesUrls.get();
    Set<String> existingUrls =
        Set.from(existingUrlsSnapshot.docs.map((doc) => doc['url']));

    ListResult results =
        await FirebaseStorage.instance.ref('Task3_Files').listAll();

    for (var i in results.items) {
      String url = await i.getDownloadURL();

      if (!existingUrls.contains(url)) {
        filesUrls.add({"url": url , "id" : filesUrls.doc().id});
      }
    }
  }
}
