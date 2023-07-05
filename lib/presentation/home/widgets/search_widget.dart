import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';
import 'package:music_player/application/search/search_bloc.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/library/widgets/playlist/playlist_widget.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AllSongSerach extends StatelessWidget {
  const AllSongSerach({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.searchList.isNotEmpty
            ? ListView.separated(
                itemBuilder: (cntx, indx) {
                  var song = state.searchList[indx];
                  bool isFavSong = isFav(song);
                  return SearchSongs(
                    indx: indx,
                    isFavSong: isFavSong,
                    searchSongs: state.searchList,
                    song: song,
                  );
                },
                separatorBuilder: (cntx, indx) {
                  return Divider();
                },
                itemCount: state.searchList.length)
            : const Center(
                child: Text(
                  'No songa Found',
                  style: mainHead,
                ),
              );
      },
    );
  }
}

class SearchSongs extends StatefulWidget {
  List<AllSongsLists> searchSongs;
  AllSongsLists song;
  int indx;
  bool isFavSong;
  SearchSongs({
    super.key,
    required this.indx,
    required this.isFavSong,
    required this.searchSongs,
    required this.song,
  });

  @override
  State<SearchSongs> createState() => _SearchSongsState();
}

class _SearchSongsState extends State<SearchSongs> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.indx, widget.searchSongs);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: ListTile(
          tileColor: Color.fromARGB(113, 37, 36, 36),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: QueryArtworkWidget(
              id: widget.song.songID,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Icon(Icons.music_note),
            ),
            radius: 30,
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
                      if (!widget.isFavSong) {
                        context
                            .read<FavouriteBloc>()
                            .add(FavoutiesAddEvent(favSong: widget.song));

                        widget.isFavSong = !widget.isFavSong;
                      } else {
                        context
                            .read<FavouriteBloc>()
                            .add(FavoutieDeleteEvent(favSong: widget.song));
                        widget.isFavSong = !widget.isFavSong;
                      }
                    });
                  },
                  icon: !widget.isFavSong
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
