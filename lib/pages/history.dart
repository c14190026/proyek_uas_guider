// ignore_for_file: prefer_const_constructors, TODO,, avoid_print, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dbservices.dart';
import '../widgets/youtubeplayer.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late CollectionReference _colRefContentHistory;
  @override
  void initState() {
    // TODO: implement initState

    final userUID = FirebaseAuth.instance.currentUser!.uid;
    _colRefContentHistory = FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('history');

    super.initState();
  }

  Stream<QuerySnapshot<Object?>> Data(
      CollectionReference<Object?> colRefContentBasic) {
    if (mounted) {
      setState(() {});
    }
    return Database.getContent(colRefContentBasic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            child: StreamBuilder<QuerySnapshot>(
              stream: Data(_colRefContentHistory),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                } else if (snapshot.hasData || snapshot.data != null) {
                  // print(snapshot.data!.docs.length);
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot contentDs = snapshot.data!.docs[index];
                        print("HIIIIIIIII ${contentDs['link']}");

                        return Center(
                          child: YtPlayer(Youtube_link: contentDs['link']),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 10);
                      },
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white70,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
