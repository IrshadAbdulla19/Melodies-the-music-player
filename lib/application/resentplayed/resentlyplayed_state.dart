part of 'resentlyplayed_bloc.dart';

class ResentlyplayedState {
  List<AllSongsLists> resentplayedBloc;
  ResentlyplayedState({required this.resentplayedBloc});
}

class ResentlyplayedInitial extends ResentlyplayedState {
  ResentlyplayedInitial() : super(resentplayedBloc: resentPlayedListBloc);
}
