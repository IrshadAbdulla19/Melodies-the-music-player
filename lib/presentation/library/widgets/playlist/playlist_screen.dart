import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/application/playlist/playlist_bloc.dart';

import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/songlists_db/playlist/play_list_model.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/current_play/current_play_screen.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListScreen extends StatefulWidget {
  PlayListScreen({super.key, required this.playlist, required this.index});
  PlayListModel playlist;
  int index;

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  // late Box<PlayListModel> playlistBox;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   playlistBox = Hive.box('playlist_db');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.keyboard_arrow_down_sharp))),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text(
                            widget.playlist.name,
                            style: mainHead,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: BlocBuilder<PlaylistBloc, PlaylistState>(
                            builder: (context, state) {
                              var playlistList = state.thisPlaylist;
                              return ListView.separated(
                                  itemBuilder: (cntx, indx) {
                                    var song =
                                        playlistList[widget.index].songs?[indx];
                                    bool isFavSong = isFav(song);
                                    return SongListPlaylist(
                                      isFavsong: isFavSong,
                                      index: indx,
                                      allsongs:
                                          playlistList[widget.index].songs,
                                      song: song,
                                      item: widget.playlist,
                                      playlistIndex: widget.index,
                                    );
                                  },
                                  separatorBuilder: (cntx, indx) {
                                    return Divider();
                                  },
                                  itemCount:
                                      widget.playlist.songs?.length ?? 0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}

class SongListPlaylist extends StatefulWidget {
  SongListPlaylist(
      {super.key,
      required this.song,
      required this.item,
      required this.allsongs,
      required this.index,
      required this.isFavsong,
      required this.playlistIndex});
  AllSongsLists? song;
  PlayListModel item;
  bool isFavsong;
  int index;
  List<AllSongsLists>? allsongs;
  int playlistIndex;

  @override
  State<SongListPlaylist> createState() => _SongListPlaylistState();
}

class _SongListPlaylistState extends State<SongListPlaylist> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.allsongs);
        Navigator.push(context, MaterialPageRoute(builder: (cntx) {
          return CurrentPlayScreen();
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.song!.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.song?.name ?? 'song name',
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
                widget.song?.artist ?? 'artits',
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
                    if (!widget.isFavsong) {
                      addFavsongs(widget.song, context);
                      widget.isFavsong = !widget.isFavsong;
                    } else {
                      deleteFavSong(widget.song);
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
                onPressed: () {
                  context.read<PlaylistBloc>().add(PlaylistDeleteSong(
                      song: widget.song,
                      playlist: widget.item,
                      index: widget.index));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
    // );
    // },
    // );
  }
}
