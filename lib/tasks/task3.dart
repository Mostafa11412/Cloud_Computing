import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
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
  FilePickerResult? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;

    setState(() {
      pickedFile = result;
    });
  }

  Future uploadFile() async {
    if (pickedFile != null) {
      try {
        final path = 'Task3_Files/${pickedFile!.files.single.name}';
        Uint8List? file = pickedFile!.files.single.bytes;

        final ref = FirebaseStorage.instance.ref().child(path);
        ref.putData(file!);

        final snackBar = SnackBar(
          content: Text('File Uploaded to FireBase Storage Succefully'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        await saveUrls();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 3"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: Text(
                    "Select Files",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            pickedFile != null
                ? Center(
                    child: ElevatedButton(
                        onPressed: () {
                          uploadFile();
                        },
                        child: Text(
                          "Upload Files",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
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
        filesUrls.add({"url": url, "id": filesUrls.doc().id});
      }
    }
  }
}
