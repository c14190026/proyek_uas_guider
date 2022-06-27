// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  //subscription akan diupdate saat menekan tombol buy apda alert dialog
  //ada 4 kondisi, pertama "" atau null, Beginner, Intermediate, Advanced
  //digunakkan saat memanggil widget expanded dimana di if dengan menggunakkan ternary operator
  String? sub_state;

  @override
  Widget build(BuildContext context) {
    //var height_halaman = MediaQuery.of(context).size.height;
    var width_halaman = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text(sub_state == "Beginner" ? "Beginner Class"
        : sub_state == "Intermediate" ? "Intermediate Class"
        : sub_state == "Advanced" ? "Advanced Class"
        : "Subscription"),
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                sub_state == "Beginner" ? 

                //beginner
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.amber,
                        child: Text("Beginner"),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ) : sub_state == "Intermediate" ? 

                //intermediate
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.amber,
                        child: Text("Intermediate"),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ) : sub_state == "Advanced" ? 

                //advanced
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.amber,
                        child: Text("Advanced"),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ) : 
                
                //belum subscribe
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        width: width_halaman,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      index == 0
                                          ? "In this subcription plan, you will get beginner class video tutorials."
                                          : index == 1
                                              ? "In this subcription plan, you will get intermediate class video tutorials."
                                              : "In this subcription plan, you will get advanced class video tutorials.",
                                      style: (TextStyle(
                                        color: Color.fromARGB(255, 10, 10, 10),
                                      )),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      index == 0
                                          ? "\$29.99"
                                          : index == 1
                                              ? "\$39.99"
                                              : "\$49.99",
                                      style: (TextStyle(
                                        color: Color.fromARGB(255, 10, 10, 10),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RawMaterialButton(
                                          onPressed: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Text(
                                                  index == 0
                                                      ? "Beginner Subscription"
                                                      : index == 1
                                                          ? "Intermediate Subscription"
                                                          : "Advanced Subscription",
                                                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      if (index == 0) {
                                                        setState(() {
                                                          sub_state =
                                                              "Beginner";
                                                        });
                                                      } else if (index == 1) {
                                                        setState(() {
                                                          sub_state =
                                                              "Intermediate";
                                                        });
                                                      } else if (index == 2) {
                                                        setState(() {
                                                          sub_state =
                                                              "Advanced";
                                                        });
                                                      }
                                                      Navigator.pop(
                                                          context, 'Buy');
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            index == 0
                                                                ? "Thank you for buying Beginner Subscription (\$29.99)"
                                                                : index == 1
                                                                    ? "Thank you for buying Intermediate Subscription (\$39.99)"
                                                                    : "Thank you for buying Advanced Subscription (\$49.99)",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text("Buy"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          elevation: 2.0,
                                          fillColor: index == 0
                                              ? Colors.green
                                              : index == 1
                                                  ? Colors.lightBlueAccent
                                                  : Color.fromARGB(
                                                      255, 212, 195, 42),
                                          child: Icon(
                                            Icons.currency_exchange_rounded,
                                            size: 25,
                                          ),
                                          padding: EdgeInsets.all(15.0),
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
                                  : Color.fromARGB(255, 212, 195, 42),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
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
