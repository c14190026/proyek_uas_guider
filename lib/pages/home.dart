// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, TODO

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/dbservices.dart';

import '../widgets/youtubeplayer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String yt_link = '';

  @override
  void initState() {
    // TODO: implement initState
    yt_link =
        'https://youtu.be/8fLie0tmhcA?list=PLl6facSXoKMrBxF3dQ4StdqtTJtfuxkZ5';

    Data();
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> Data() {
    setState(() {});
    return Database.getContent();
  }

  @override
  Widget build(BuildContext context) {
    // print('HIIIIIIIIIIIII $Data()');
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //TODO: Basic Tutorial
                  StreamBuilder<QuerySnapshot>(
                    stream: Data(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        // print(snapshot.data!.docs.length);
                        return CarouselSlider.builder(
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.85,
                            enableInfiniteScroll: true,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            DocumentSnapshot contentDs =
                                snapshot.data!.docs[index];
                            return Builder(
                              builder: (context) {
                                // print("HIIIIIIIIIII ${contentDs['link']}");
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: Colors.white70),
                                  child: YtPlayer(
                                    Youtube_link: contentDs['link'],
                                    currPos: const Duration(seconds: 0),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
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
                  //TODO Trending Covers
                  StreamBuilder<QuerySnapshot>(
                    stream: Data(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return Text('1');
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
