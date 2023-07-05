part of 'for_nav_bloc.dart';

class ForNavState {
  final int index;

  ForNavState({required this.index});
}

class ForNavInitial extends ForNavState {
  ForNavInitial() : super(index: 0);
}
