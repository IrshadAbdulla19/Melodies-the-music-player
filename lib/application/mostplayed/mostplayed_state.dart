part of 'mostplayed_bloc.dart';

class MostplayedState {
  List<AllSongsLists> mostplayBlocList;
  MostplayedState({required this.mostplayBlocList});
}

class MostplayedInitial extends MostplayedState {
  MostplayedInitial() : super(mostplayBlocList: mostPlayedListBloc);
}
