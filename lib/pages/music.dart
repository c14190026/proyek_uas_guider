// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyek_uas_guider/dbservices.dart';
import 'package:proyek_uas_guider/widgets/youtubeplayer.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
bool hasPressed1 = false;
bool hasPressed2 = false;

late CollectionReference _colRefContentSearch;
final searchTitle = TextEditingController();

@override
void initState() {
  searchTitle.addListener(onSearch);
_colRefContentSearch = FirebaseFirestore.instance
        .collection('contents')
        .doc('nonsubscriptions')
        .collection('covers');
    super.initState();
}

void dispose() {
    searchTitle.dispose();
    super.dispose();
  }

Stream<QuerySnapshot<Object?>> Data(
      CollectionReference<Object?> colRefContentSearch) {
    setState(() {});
    return Database.getContent(colRefContentSearch);
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {});
    return Database.getSearch(searchTitle.text);
  }

  Stream<QuerySnapshot<Object?>> onPressTitle() {
    return Database.getPressTitle(hasPressed1);
  }

  Stream<QuerySnapshot<Object?>> onPressDifficulty() {
    return Database.getPressDifficulty(hasPressed2);
  }

Color fungsiWarna1 (Set<MaterialState> states) {
  onPressTitle();
  if (hasPressed1 == false)
  return Colors.black.withOpacity(.1);
  else
  return Color.fromARGB(15, 224, 224, 224);
}

Color fungsiWarna2 (Set<MaterialState> states) {
  onPressDifficulty();
  if (hasPressed2 == false)
  return Colors.black.withOpacity(.1);
  else
  return Color.fromARGB(15, 224, 224, 224);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text('Search for Videos'),
        centerTitle: true,
        backgroundColor: Color(0xFF171717),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables

              //Label Search
              children: [
              //SearchBar
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextField(autofocus: true,
              controller: searchTitle,
              decoration: InputDecoration(
                labelText: "Search for songs to play",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white,),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                ), style: TextStyle(color: Colors.white),
              ),),

              //Filter
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(children: [
                //Filter Title
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    hasPressed1 = !hasPressed1;
                  });
                  },
                  
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(fungsiWarna1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),),)),
                  
                child: Text("Title", style: TextStyle(color: Colors.white),)),
                ),
                
                //Filter Difficulty
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    hasPressed2 = !hasPressed2;
                  });
                  },
                  
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(fungsiWarna2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),),)),
                  
                child: Text("Difficulty", style: TextStyle(color: Colors.white),)),
                ),
                
              ],
              ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: onSearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      // print(snapshot.data!.docs.length);
                      return Expanded(
                        child: 
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.vertical,
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
                            itemCount: snapshot.data!.docs.length
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
              ],
              ),
            ),
          ),
        ),
      );
  }
}

// //Empty background
//               Container(
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Image.asset("lib/assets/images/search.png",
//                       width: 200, height: 200),
//                       Text("No videos found", 
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                       Text("Try searching for a different video",
//                       style: TextStyle(color: Colors.white))
//                       ] 
//                     ),
//                 )
//               )