// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, TODO, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/dbservices.dart';

import '../userdata.dart';
import '../widgets/youtubeplayer.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  //subscription akan diupdate saat menekan tombol buy apda alert dialog
  //ada 4 kondisi, pertama "" atau null, Beginner, Intermediate, Advanced
  //digunakkan saat memanggil widget expanded dimana di if dengan menggunakkan ternary operator
  late final CollectionReference _colRefContentSubs;
  String sub_state = '';

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getUserData() {
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    final userData = Database.getData(uid: userUID);
    userData.then(
      (DocumentSnapshot docsnap) {
        if (docsnap.exists) {
          if (mounted) {
            setState(
              () {
                sub_state = docsnap.get('userSubs');
                if (sub_state != '') {
                  _colRefContentSubs = FirebaseFirestore.instance
                      .collection('contents')
                      .doc('subscriptions')
                      .collection(
                        sub_state,
                      );
                } else {
                  sub_state = '';
                }
              },
            );
          }
        } else {
          print('Not Found');
        }
      },
    );
  }

  Stream<QuerySnapshot<Object?>> Data(
      CollectionReference<Object?> colRefContentSubs) {
    if (mounted) {
      setState(() {});
    }
    return Database.getContent(colRefContentSubs);
  }

  @override
  Widget build(BuildContext context) {
    var width_halaman = MediaQuery.of(context).size.width;

    print("$sub_state hai");

    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text(sub_state == "beginners"
            ? "Beginner Class"
            : sub_state == "intermediates"
                ? "Intermediate Class"
                : sub_state == "advanceds"
                    ? "Advanced Class"
                    : "Subscription"),
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                sub_state == "beginners"
                    ?

                    //TODO: beginner
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Data(_colRefContentSubs),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error');
                            } else if (snapshot.hasData ||
                                snapshot.data != null) {
                              return Expanded(
                                child: ListView.separated(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot contentDs =
                                        snapshot.data!.docs[index];
                                    return Center(
                                      child: YtPlayer(
                                        Youtube_link: contentDs['link'],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
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
                      )
                    : sub_state == "intermediates"
                        ?

                        //TODO: intermediate
                        Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: Data(_colRefContentSubs),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error');
                                } else if (snapshot.hasData ||
                                    snapshot.data != null) {
                                  return Expanded(
                                    child: ListView.separated(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot contentDs =
                                            snapshot.data!.docs[index];
                                        return Center(
                                          child: YtPlayer(
                                            Youtube_link: contentDs['link'],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
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
                          )
                        : sub_state == "advanceds"
                            ?

                            //TODO: advanced
                            Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Data(_colRefContentSubs),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error');
                                    } else if (snapshot.hasData ||
                                        snapshot.data != null) {
                                      return Expanded(
                                        child: ListView.separated(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            DocumentSnapshot contentDs =
                                                snapshot.data!.docs[index];
                                            return Center(
                                              child: YtPlayer(
                                                Youtube_link: contentDs['link'],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white70,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            :

                            //TODO: belum subscribe
                            Expanded(
                                child: ListView.separated(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 16),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: width_halaman,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              index == 0
                                                  ? "BEGINNER"
                                                  : index == 1
                                                      ? "INTERMEDIATE"
                                                      : "ADVANCED",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            width: width_halaman,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Text(
                                                    index == 0
                                                        ? "In this subcription plan, you will get beginner class video tutorials."
                                                        : index == 1
                                                            ? "In this subcription plan, you will get intermediate class video tutorials."
                                                            : "In this subcription plan, you will get advanced class video tutorials.",
                                                    style: (TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 10, 10, 10),
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Text(
                                                    index == 0
                                                        ? "\$29.99"
                                                        : index == 1
                                                            ? "\$39.99"
                                                            : "\$49.99",
                                                    style: (TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 10, 10, 10),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      RawMaterialButton(
                                                        onPressed: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: Text(
                                                                index == 0
                                                                    ? "Beginner Subscription"
                                                                    : index == 1
                                                                        ? "Intermediate Subscription"
                                                                        : "Advanced Subscription",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              content: Text(
                                                                index == 0
                                                                    ? "Would you like to buy Beginner Subscription for \$29.99 ?"
                                                                    : index == 1
                                                                        ? "Would you like to buy Intermediate Subscription for \$39.99 ?"
                                                                        : "Would you like to buy Advanced Subscription for \$49.99 ?",
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel');
                                                                  },
                                                                  child: Text(
                                                                      "Cancel"),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    final userUID = FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid;

                                                                    final userData =
                                                                        Database.getData(
                                                                            uid:
                                                                                userUID);

                                                                    if (index ==
                                                                        0) {
                                                                      userData
                                                                          .then(
                                                                        (DocumentSnapshot
                                                                            docsnap) {
                                                                          if (docsnap
                                                                              .exists) {
                                                                            final updateUserData =
                                                                                userDatabase(
                                                                              userName: docsnap.get('userName').toString(),
                                                                              userEmail: docsnap.get('userEmail').toString(),
                                                                              userSubs: 'beginners',
                                                                              userPic: docsnap.get('userPic').toString(),
                                                                            );
                                                                            Database.updateData(user: updateUserData, uid: userUID).whenComplete(() {}).then(
                                                                              (value) {
                                                                                if (mounted) {
                                                                                  if (mounted) {
                                                                                    setState(
                                                                                      () {
                                                                                        getUserData();
                                                                                      },
                                                                                    );
                                                                                  }
                                                                                }
                                                                              },
                                                                            );
                                                                          }
                                                                        },
                                                                      );
                                                                    } else if (index ==
                                                                        1) {
                                                                      userData
                                                                          .then(
                                                                        (DocumentSnapshot
                                                                            docsnap) {
                                                                          if (docsnap
                                                                              .exists) {
                                                                            final updateUserData =
                                                                                userDatabase(
                                                                              userName: docsnap.get('userName').toString(),
                                                                              userEmail: docsnap.get('userEmail').toString(),
                                                                              userSubs: 'intermediates',
                                                                              userPic: docsnap.get('userPic').toString(),
                                                                            );
                                                                            Database.updateData(user: updateUserData, uid: userUID).whenComplete(() {}).then(
                                                                              (value) {
                                                                                if (mounted) {
                                                                                  setState(
                                                                                    () {
                                                                                      getUserData();
                                                                                    },
                                                                                  );
                                                                                }
                                                                              },
                                                                            );
                                                                          }
                                                                        },
                                                                      );
                                                                    } else if (index ==
                                                                        2) {
                                                                      userData
                                                                          .then(
                                                                        (DocumentSnapshot
                                                                            docsnap) {
                                                                          if (docsnap
                                                                              .exists) {
                                                                            final updateUserData =
                                                                                userDatabase(
                                                                              userName: docsnap.get('userName').toString(),
                                                                              userEmail: docsnap.get('userEmail').toString(),
                                                                              userSubs: 'advanceds',
                                                                              userPic: docsnap.get('userPic').toString(),
                                                                            );
                                                                            Database.updateData(user: updateUserData, uid: userUID).whenComplete(() {}).then(
                                                                              (value) {
                                                                                if (mounted) {
                                                                                  setState(
                                                                                    () {
                                                                                      getUserData();
                                                                                    },
                                                                                  );
                                                                                }
                                                                              },
                                                                            );
                                                                          }
                                                                        },
                                                                      );
                                                                    }
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Buy');
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          index == 0
                                                                              ? "Thank you for buying Beginner Subscription (\$29.99)"
                                                                              : index == 1
                                                                                  ? "Thank you for buying Intermediate Subscription (\$39.99)"
                                                                                  : "Thank you for buying Advanced Subscription (\$49.99)",
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      "Buy"),
                                                                ),
                                                              ],
                                                            ),
                                                          ).then(
                                                            (value) {
                                                              if (mounted) {
                                                                setState(
                                                                  () {
                                                                    getUserData();
                                                                  },
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                        elevation: 2.0,
                                                        fillColor: index == 0
                                                            ? Colors.green
                                                            : index == 1
                                                                ? Colors
                                                                    .lightBlueAccent
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        212,
                                                                        195,
                                                                        42),
                                                        child: Icon(
                                                          Icons
                                                              .currency_exchange_rounded,
                                                          size: 25,
                                                        ),
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        shape: CircleBorder(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: index == 0
                                            ? Colors.green
                                            : index == 1
                                                ? Colors.lightBlueAccent
                                                : Color.fromARGB(
                                                    255, 212, 195, 42),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                ),
                              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}