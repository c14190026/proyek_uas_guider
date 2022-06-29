// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyek_uas_guider/extension/extensions.dart';
import 'package:proyek_uas_guider/userdata.dart';

CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('users');

FirebaseStorage storage = FirebaseStorage.instance;

CollectionReference _colRefContentSearch = FirebaseFirestore.instance
    .collection('contents')
    .doc('nonsubscriptions')
    .collection('covers');

class Database {
  static Stream<QuerySnapshot> getContent(_collectionReferenceContent) {
    return _collectionReferenceContent.snapshots();
  }

  static Future<DocumentSnapshot<Object?>> getData({required uid}) {
    return _collectionReference.doc(uid).get();
  }

  static Stream<QuerySnapshot> getSearch(
      String judul, bool press1, bool press2) {
    String temp = judul.capitalize();
    if (judul == "") {
      return _colRefContentSearch.snapshots();
    } else if (press1 == true && press2 == false && judul != "") {
      return _colRefContentSearch
          .orderBy('title')
          .startAt([temp]).endAt([temp + '\uf8ff']).snapshots();
    } else if (press1 == false && press2 == true && judul != "") {
      return _colRefContentSearch
          .orderBy('level')
          .startAt([temp]).endAt([temp + '\uf8ff']).snapshots();
    } else {
      return _colRefContentSearch.snapshots();
    }
  }

  static Stream<QuerySnapshot> getPressTitle(bool press) {
    if (press == false) {
      return _colRefContentSearch.snapshots();
    } else {
      return _colRefContentSearch.orderBy('title').snapshots();
    }
  }

  static Stream<QuerySnapshot> getPressDifficulty(bool press) {
    if (press == false) {
      return _colRefContentSearch.snapshots();
    } else {
      return _colRefContentSearch.orderBy('difficulty').snapshots();
    }
  }

  static Future<void> addData(
      {required userDatabase user, required uid}) async {
    DocumentReference _documentReference = _collectionReference.doc(uid);

    await _documentReference
        .set(user.tojson())
        .whenComplete(() => print('UserData Successfully Added'))
        .catchError((e) => print(e));
  }

  static Future<void> updateData(
      {required userDatabase user, required uid}) async {
    DocumentReference _documentReference = _collectionReference.doc(uid);

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

class Auth {
  static Future<void> signIn({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future<void> signUp({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class FireStorage {
  static Future<void> updateProfilePic(
      {required filepath, required uid}) async {
    File file = File(filepath);

    try {
      await storage.ref('users/$uid').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  static Future<void> getProfilePiv({required uid}) async {}
}
