import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_player/application/favourite/favourite_bloc.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';

import 'package:music_player/infrastructure/db/functions/functions.dart';

import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/favourite/widgets/fav_widget.dart';

import 'package:music_player/presentation/library/widgets/playlist/playlist_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatelessWidget {
  SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AllSongsNotifier,
        builder: (BuildContext context, List<AllSongsLists> allSongs,
            Widget? child) {
          return allSongs.length == 0
              ? Text(
                  'No songs',
                  style: mainHead,
                )
              : ListView.separated(
                  itemBuilder: (cntx, indx) {
                    var song = allSongs[indx];
                    bool isFavSong = isFav(song);
                    return AllSongsList(
                      song: song,
                      allSongs: allSongs,
                      index: indx,
                      isFavsong: isFavSong,
                    );
                  },
                  separatorBuilder: (cntx, indx) {
                    return Divider();
                  },
                  itemCount: allSongs.length);
        });
  }
}

class AllSongsList extends StatefulWidget {
  AllSongsList(
      {super.key,
      required this.song,
      required this.allSongs,
      required this.index,
      required this.isFavsong});
  AllSongsLists song;
  List<AllSongsLists> allSongs;
  int index;
  bool isFavsong;

  @override
  State<AllSongsList> createState() => _AllSongsListState();
}

class _AllSongsListState extends State<AllSongsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.allSongs);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: ListTile(
          tileColor: Color.fromARGB(113, 37, 36, 36),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 30,
            child: QueryArtworkWidget(
              id: widget.song.songID,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(Icons.music_note),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.song.name,
                  overflow: TextOverflow.ellipsis,
                  style: songNameText,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.song.artist,
                  overflow: TextOverflow.ellipsis,
                  style: artistNameText,
                ),
              ),
            ],
          ),
          trailing: Wrap(
            spacing: 1,
            children: [
              IconButton(
                  iconSize: 35,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (!widget.isFavsong) {
                        context
                            .read<FavouriteBloc>()
                            .add(FavoutiesAddEvent(favSong: widget.song));

                        widget.isFavsong = !widget.isFavsong;
                      } else {
                        context
                            .read<FavouriteBloc>()
                            .add(FavoutieDeleteEvent(favSong: widget.song));
                        widget.isFavsong = !widget.isFavsong;
                      }
                    });
                  },
                  icon: !widget.isFavsong
                      ? Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
              IconButton(
                  iconSize: 35,
                  color: Colors.white,
                  onPressed: () {
                    bottomSheet(context, widget.song);
                  },
                  icon: Icon(Icons.playlist_add))
            ],
          ),
        ),
      ),
    );
  }

  Future bottomSheet(BuildContext cntx, AllSongsLists song) {
    return showModalBottomSheet(
        context: cntx,
        builder: (BuildContext context) {
          var mediaQuary = MediaQuery.of(context);
          return PlayListShowWidget(
            mediaQuary: mediaQuary,
            song: song,
          );
        });
  }
}
