import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/resentplayed/resentlyplayed_bloc.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'playlist/playlist_widget.dart';

class ResentlyPlayed extends StatelessWidget {
  const ResentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResentlyplayedBloc, ResentlyplayedState>(
      builder: (context, state) {
        var resentSongs = state.resentplayedBloc;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: resentSongs.length,
            itemBuilder: (cntx, indx) {
              print(resentSongs.length);
              var song = resentSongs[indx];
              bool isFavSong = isFav(song);
              return SongListResentlyPlayed(
                isFavSong: isFavSong,
                index: indx,
                resentSongs: resentSongs,
                song: song,
              );
            });
      },
    );
  }
}

class SongListResentlyPlayed extends StatefulWidget {
  SongListResentlyPlayed(
      {super.key,
      required this.song,
      required this.index,
      required this.resentSongs,
      required this.isFavSong});
  AllSongsLists song;
  int index;
  List<AllSongsLists> resentSongs;
  bool isFavSong;

  @override
  State<SongListResentlyPlayed> createState() => _SongListResentlyPlayedState();
}

class _SongListResentlyPlayedState extends State<SongListResentlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return
        // ValueListenableBuilder(
        //   valueListenable: ,
        //   builder: (context, value, child) {
        //     return GestureDetector(
        //       child:
        GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.resentSongs);
        // Navigator.push(context, MaterialPageRoute(builder: (cntx) {
        //   return CurrentPlayScreen();
        // }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.song.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.song.name,
                style: songNameText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(widget.song.artist,
                  style: artistNameText, overflow: TextOverflow.ellipsis),
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
                      addFavsongs(widget.song, context);
                      widget.isFavSong = !widget.isFavSong;
                    } else {
                      deleteFavSong(widget.song);
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
