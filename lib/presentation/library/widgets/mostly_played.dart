import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';

import 'package:music_player/application/mostplayed/mostplayed_bloc.dart';
import 'package:music_player/functions/home_screen/home_function.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';

import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'playlist/playlist_widget.dart';

class MostlyPlayed extends StatelessWidget {
  const MostlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostplayedBloc, MostplayedState>(
      builder: (context, state) {
        var mostSongs = state.mostplayBlocList;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                // mostPlayedList.length,
                mostSongs.length < 10 ? mostSongs.length : 10,
            itemBuilder: (cntx, indx) {
              var mostSong = mostSongs[indx];
              bool isFavSong = isFav(mostSong);
              return SongListMostlyPlayed(
                mostSongs: mostSongs,
                index: indx,
                mostSong: mostSong,
                isFavSong: isFavSong,
              );
            });
      },
    );
  }
}

class SongListMostlyPlayed extends StatefulWidget {
  SongListMostlyPlayed(
      {super.key,
      required this.mostSong,
      required this.index,
      required this.mostSongs,
      required this.isFavSong});
  AllSongsLists mostSong;
  int index;
  List<AllSongsLists> mostSongs;
  bool isFavSong;

  @override
  State<SongListMostlyPlayed> createState() => _SongListMostlyPlayedState();
}

class _SongListMostlyPlayedState extends State<SongListMostlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.mostSongs);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.mostSong.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.mostSong.name,
                style: songNameText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                widget.mostSong.artist,
                style: artistNameText,
                overflow: TextOverflow.ellipsis,
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
                          .add(FavoutiesAddEvent(favSong: widget.mostSong));

                      widget.isFavSong = !widget.isFavSong;
                    } else {
                      context
                          .read<FavouriteBloc>()
                          .add(FavoutieDeleteEvent(favSong: widget.mostSong));
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
                  bottomSheet(context, widget.mostSong);
                },
                icon: Icon(Icons.playlist_add))
          ],
        ),
      ),
    );
    // );
    // },
    // );
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
