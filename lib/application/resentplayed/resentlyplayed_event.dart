part of 'resentlyplayed_bloc.dart';

@immutable
abstract class ResentlyplayedEvent {}

class ResentplayedAddEvent extends ResentlyplayedEvent {
  final AllSongsLists resentSong;
  ResentplayedAddEvent({required this.resentSong});
}
