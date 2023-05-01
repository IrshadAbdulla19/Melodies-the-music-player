import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_player/widgets/favourite_screen/song_list_fav.dart';
import 'package:music_player/widgets/favourite_screen/top_part_fav.dart';

class FavoutieScreen extends StatefulWidget {
  const FavoutieScreen({super.key});

  @override
  State<FavoutieScreen> createState() => _FavoutieScreenState();
}

class _FavoutieScreenState extends State<FavoutieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'Favourites',
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontFamily: 'Dongle',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TopPartFavourite(),
                        Expanded(
                            flex: 3,
                            child: ListView.separated(
                                itemBuilder: (cntx, indx) {
                                  return SongListFavourite();
                                },
                                separatorBuilder: (cntx, indx) {
                                  return Divider();
                                },
                                itemCount: 10)),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
