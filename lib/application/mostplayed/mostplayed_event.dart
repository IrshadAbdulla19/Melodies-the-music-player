part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedEvent {}

class MostplayedlistAddEvent extends MostplayedEvent {
  final AllSongsLists mostPlaySong;
  MostplayedlistAddEvent({required this.mostPlaySong});
}
