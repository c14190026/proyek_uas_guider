// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_uas_guider/userdata.dart';

CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('');

class Database {
  static Stream<QuerySnapshot> getData() {
    return _collectionReference.snapshots();
  }

  static Future<void> addData({required userDatabase user}) async {
    DocumentReference _documentReference = _collectionReference.doc('');

    await _documentReference
        .set(user.tojson())
        .whenComplete(() => print('UserData Successfully Added'))
        .catchError((e) => print(e));
  }

  static Future<void> updateData({required userDatabase user}) async {
    DocumentReference _documentReference = _collectionReference.doc('');

    await _documentReference
        .update(user.tojson())
        .whenComplete(() => print('UserData Successfully Updated'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required userDatabase user}) async {
    DocumentReference _documentReference = _collectionReference.doc('');

    await _documentReference
        .delete()
        .whenComplete(() => print('UserData Successfully Deleted'))
        .catchError((e) => print(e));
  }
}
