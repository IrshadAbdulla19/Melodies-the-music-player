import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/infrastructure/db/functions/resent_played_db.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

part 'resentlyplayed_event.dart';
part 'resentlyplayed_state.dart';

class ResentlyplayedBloc
    extends Bloc<ResentlyplayedEvent, ResentlyplayedState> {
  ResentlyplayedBloc() : super(ResentlyplayedInitial()) {
    on<ResentplayedAddEvent>((event, emit) {
      addResentPlyed(event.resentSong);
      state.resentplayedBloc =
          List<AllSongsLists>.from(resentPlayedListBloc.reversed);
      return emit(
          ResentlyplayedState(resentplayedBloc: state.resentplayedBloc));
    });
  }
}
