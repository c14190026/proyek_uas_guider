// ignore_for_file: prefer_const_constructors, TODO, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:proyek_uas_guider/content.dart';
import 'package:proyek_uas_guider/dbservices.dart';
import 'package:proyek_uas_guider/widgets/youtubeplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtDisplay extends StatefulWidget {
  final DocumentSnapshot ytid;
  const YtDisplay({Key? key, required this.ytid}) : super(key: key);

  @override
  State<YtDisplay> createState() => _YtDisplayState();
}

class _YtDisplayState extends State<YtDisplay> {
  String youtubeid = '';
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    youtubeid = YoutubePlayer.convertUrlToId(widget.ytid['link']).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          cacheManager: customCacheManager,
          key: UniqueKey(),
          //TODO: Link Thumbnail
          imageUrl: "https://img.youtube.com/vi/$youtubeid/0.jpg",
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //TODO: Button play
              Center(
                child: GestureDetector(
                  onTap: () {
                    final ContentHis = contentDatabase(
                        contentName: widget.ytid['title'],
                        contentLink: widget.ytid['link']);
                    Database.addHistory(
                      content: ContentHis,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      title: widget.ytid['title'],
                    ).then(
                      (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YtPlayer(YtData: widget.ytid),
                          ),
                        ).then((value) {
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: SystemUiOverlay.values);
                          SystemChrome.setPreferredOrientations(
                            [
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(200, 21, 21, 23),
                      ),
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

// Wrap(
//       children: [
//         Stack(
//           children: [
//             AspectRatio(
//               aspectRatio: 16/9,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: CachedNetworkImage(
//                   cacheManager: customCacheManager,
//                   key: UniqueKey(),
//                   imageUrl: "https://img.youtube.com/vi/$youtubeid/0.jpg",
//                   imageBuilder: (context, imageProvider) => Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   placeholder: (context, url) => Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 ),
//               ),
//             ),
//             Center(
//               child: Container(
//                 padding: EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color.fromARGB(40, 255, 255, 255),
//                 ),
//                 child: Icon(
//                   LineIcons.play,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
