// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
bool hasPressed1 = false;
bool hasPressed2 = false;
bool hasPressed3 = false;

Color fungsiWarna1 (Set<MaterialState> states) {
  if (hasPressed1 == false)
  return Colors.blueGrey;
  else
  return Colors.white;
}

Color fungsiWarna2 (Set<MaterialState> states) {
  if (hasPressed2 == false)
  return Colors.blueGrey;
  else
  return Colors.white;
}

Color fungsiWarna3 (Set<MaterialState> states) {
  if (hasPressed3 == false)
  return Colors.blueGrey;
  else
  return Colors.white;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        title: Text('Search'),
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
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 20),
                child: Text("Search",
              style: TextStyle(color: Colors.white,
              fontSize: 26))),

              //SearchBar
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextField(autofocus: true,
              decoration: InputDecoration(
                labelText: "Search for people, games, and more",
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
                //Filter Top Trending
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
                  
                child: Text("Top Trending", style: TextStyle(color: Colors.black),)),
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
                  
                child: Text("Difficulty", style: TextStyle(color: Colors.black),)),
                ),
                
                //Filter Fingertip Type
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    hasPressed3 = !hasPressed3;
                  });
                  },
                  
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(fungsiWarna3),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),),)),
                  
                child: Text("Fingertip Type", style: TextStyle(color: Colors.black),)),
                ),
              ],
              ),
              ),

              //Empty background
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset("lib/assets/images/search.png",
                      width: 200, height: 200),
                      Text("Search for people, games, and more", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Find your favorite games and friends",
                      style: TextStyle(color: Colors.white))
                      ] 
                    ),
                )
              )
              ],
              ),
            ),
          ),
        ),
      );
  }
}
