import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:music_player/infrastructure/db/functions/most_played.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial()) {
    on<MostplayedlistAddEvent>((event, emit) {
      addMostPlayedList(event.mostPlaySong);
      return emit(MostplayedState(mostplayBlocList: state.mostplayBlocList));
    });
  }
}
