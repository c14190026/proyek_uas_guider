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
  late CollectionReference _colRefContentBasic;
  late CollectionReference _colRefContentTrending;

  @override
  void initState() {
    // TODO: implement initState
    _colRefContentBasic = FirebaseFirestore.instance
        .collection('contents')
        .doc('nonsubscriptions')
        .collection('basics');
    _colRefContentTrending = FirebaseFirestore.instance
        .collection('contents')
        .doc('nonsubscriptions')
        .collection('covers');

    super.initState();
  }

  Stream<QuerySnapshot<Object?>> Data(
      CollectionReference<Object?> colRefContentBasic) {
    setState(() {});
    return Database.getContent(colRefContentBasic);
  }

  @override
  Widget build(BuildContext context) {
    // print('HIIIIIIIIIIIII $Data()');
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Basic Tutorial',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    height: 2,
                    color: Colors.white54,
                  ),
                ),
                //TODO: Basic Tutorial
                StreamBuilder<QuerySnapshot>(
                  stream: Data(_colRefContentBasic),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      // print(snapshot.data!.docs.length);
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          viewportFraction: 0.85,
                          enableInfiniteScroll: true,
                          autoPlay: true,
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
                              return Center(
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

                SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    height: 2,
                    color: Colors.white54,
                  ),
                ),

                Text(
                  'Trending',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    height: 2,
                    color: Colors.white54,
                  ),
                ),
                //TODO Trending Covers
                StreamBuilder<QuerySnapshot>(
                  stream: Data(_colRefContentTrending),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return Expanded(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            viewportFraction: 0.7,
                            enableInfiniteScroll: true,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.vertical,
                          ),
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            DocumentSnapshot contentDs =
                                snapshot.data!.docs[index];
                            return Center(
                              child: YtPlayer(
                                Youtube_link: contentDs['link'],
                                currPos: const Duration(seconds: 0),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
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
                SizedBox(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    height: 2,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Expanded(
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             DocumentSnapshot contentDs =
//                                 snapshot.data!.docs[index];
//                             return Builder(
//                               builder: (context) {
//                                 return Container(
//                                   padding: EdgeInsets.all(5),
//                                   width: MediaQuery.of(context).size.width,
//                                   decoration:
//                                       BoxDecoration(color: Colors.white70),
//                                   child: YtPlayer(
//                                     Youtube_link: contentDs['link'],
//                                     currPos: const Duration(seconds: 0),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) {
//                             return Divider(
//                               height: 10,
//                             );
//                           },
//                         ),
//                       );