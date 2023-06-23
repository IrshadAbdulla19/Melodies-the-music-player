import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/domain/core/style.dart';

import 'package:music_player/presentation/home/widgets/search_widget.dart';

import 'package:music_player/presentation/home/widgets/song_list.dart';
import 'package:music_player/presentation/home/widgets/top_part.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({
    super.key,
  });

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  final _allSongController = TextEditingController();

  List<AllSongsLists> allSongs =
      Hive.box<AllSongsLists>('allsong').values.toList();

  late List<AllSongsLists> songDisplay = List<AllSongsLists>.from(allSongs);
  int searchVar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
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
                    TopPart(),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                searchVar = 1;
                              });
                            },
                            focusNode: _focusNode,
                            controller: _allSongController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => clearText()),
                                filled: true,
                                fillColor: Color.fromARGB(255, 6, 59, 102),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28))),
                            onChanged: (value) {
                              _searchStudent(value.trim());
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  _focusNode.unfocus();
                                },
                                icon: Icon(Icons.search)),
                          ),
                        )
                      ],
                    ),
                    searchVar == 0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 22.0, top: 15),
                            child: Text(
                              'All songs',
                              style: miniHead,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 22.0, top: 15),
                            child: Text(
                              'Search',
                              style: miniHead,
                            ),
                          ),
                    Expanded(
                        flex: 9,
                        child: searchVar == 0
                            ? SongList()
                            : AllSongSerach(
                                songDisplay: songDisplay,
                              )),
                    // Expanded(
                    //   flex: 2,
                    //   child: Container(
                    //     child: MiniPlayer(),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchStudent(String value) {
    setState(() {
      songDisplay = allSongs
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _allSongController.clear();
    _focusNode.unfocus();
    setState(() {
      searchVar = 0;
    });
  }
}
