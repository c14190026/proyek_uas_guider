// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyek_uas_guider/userdata.dart';

CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('users');

CollectionReference _collectionReferenceContentBasic = FirebaseFirestore
    .instance
    .collection('contents')
    .doc('nonsubscriptions')
    .collection('basics');

FirebaseStorage storage = FirebaseStorage.instance;

class Database {
  static Stream<QuerySnapshot> getContent() {
    return _collectionReferenceContentBasic.snapshots();
  }

  static Future<DocumentSnapshot<Object?>> getData({required uid}) {
    return _collectionReference.doc(uid).get();
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
