import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_player/application/favourite/favourite_bloc.dart';

import 'package:music_player/domain/core/style.dart';

import 'package:music_player/presentation/favourite/widgets/song_list_fav.dart';

class FavoutieScreen extends StatelessWidget {
  const FavoutieScreen({super.key});

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
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 22.0),
                          child: Text(
                            'Favourites',
                            style: mainHead,
                          ),
                        ),
                        // TopPartFavourite(),
                        Expanded(
                            flex: 3,
                            child: BlocBuilder<FavouriteBloc, FavouriteState>(
                              builder: (context, state) {
                                var favSongs = state.favoriteList;
                                return favSongs.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No songs',
                                          style: mainHead,
                                        ),
                                      )
                                    : ListView.separated(
                                        itemBuilder: (cntx, indx) {
                                          var song = favSongs[indx];
                                          return SongListFavourite(
                                            favSongs: favSongs,
                                            song: song,
                                            index: indx,
                                          );
                                        },
                                        separatorBuilder: (cntx, indx) {
                                          return const Divider();
                                        },
                                        itemCount: favSongs.length);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
