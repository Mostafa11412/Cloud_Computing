import 'dart:developer';

import 'package:cloud_computing/models/url_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  static CollectionReference<UrlModel> getUrlCollection() {
    return FirebaseFirestore.instance.collection('filesUrls')
    .withConverter<UrlModel>(
      fromFirestore: (snapshot, options) {
        log(snapshot['id']);
        return UrlModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Stream<QuerySnapshot<UrlModel>> getUrls(){
    var collection = getUrlCollection();
    return collection.snapshots();
  }

  static Future<void> deleteUrl(String id){
    log(getUrlCollection().doc(id).toString());
    return getUrlCollection().doc(id).delete();
  }

  // static Future<void> addUrl(UrlModel model){
  //   var collection = getUrlCollection();
  //   var docRef = collection.doc();
  //   model.id = docRef.id;
  //   return docRef.set(model);
  // }
}
