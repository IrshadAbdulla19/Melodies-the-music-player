import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/application/search/search_bloc.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

import 'package:music_player/presentation/home/widgets/search_widget.dart';

import 'package:music_player/presentation/home/widgets/song_list.dart';
import 'package:music_player/presentation/home/widgets/top_part.dart';

class HomeScreem extends StatelessWidget {
  HomeScreem({
    super.key,
  });

  final FocusNode _focusNode = FocusNode();

  final _allSongController = TextEditingController();

  List<AllSongsLists> allSongs =
      Hive.box<AllSongsLists>('allsong').values.toList();

  late List<AllSongsLists> songDisplay = List<AllSongsLists>.from(allSongs);

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
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    int searchVar = state.searchIndex ?? 0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopPart(),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFormField(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(SearchIndex(index: 1));
                                },
                                focusNode: _focusNode,
                                controller: _allSongController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () => clearText(context)),
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(255, 36, 101, 155),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))),
                                onChanged: (value) {
                                  context
                                      .read<SearchBloc>()
                                      .add(SearchList(name: value));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 15, 77, 128),
                                child: IconButton(
                                    onPressed: () {
                                      _focusNode.unfocus();
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                    )),
                              ),
                            )
                          ],
                        ),
                        searchVar == 0
                            ? const Padding(
                                padding: EdgeInsets.only(left: 22.0, top: 15),
                                child: Text(
                                  'All songs',
                                  style: miniHead,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(left: 22.0, top: 15),
                                child: Text(
                                  'Search',
                                  style: miniHead,
                                ),
                              ),
                        Expanded(
                            flex: 9,
                            child:
                                searchVar == 0 ? SongList() : AllSongSerach()),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchStudent(String value, BuildContext context) {}

  void clearText(BuildContext context) {
    _allSongController.clear();
    _focusNode.unfocus();
    context.read<SearchBloc>().add(SearchIndex(index: 0));
  }
}
