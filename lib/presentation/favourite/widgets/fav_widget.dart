import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

class FavoutieButton extends StatefulWidget {
  bool isFav;
  AllSongsLists thisSong;

  FavoutieButton({super.key, required this.isFav, required this.thisSong});

  @override
  State<FavoutieButton> createState() => _FavoutieButtonState();
}

class _FavoutieButtonState extends State<FavoutieButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return IconButton(
            iconSize: 35,
            onPressed: () {
              setState(() {
                if (state.favoriteList.contains(widget.thisSong)) {
                  widget.isFav = !widget.isFav;
                  context
                      .read<FavouriteBloc>()
                      .add(FavoutieDeleteEvent(favSong: widget.thisSong));
                } else {
                  widget.isFav = !widget.isFav;
                  context
                      .read<FavouriteBloc>()
                      .add(FavoutiesAddEvent(favSong: widget.thisSong));
                }
              });
            },
            icon: !widget.isFav
                ? Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ));
      },
    );
  }
}
