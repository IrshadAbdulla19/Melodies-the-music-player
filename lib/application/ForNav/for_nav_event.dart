part of 'for_nav_bloc.dart';

@immutable
abstract class ForNavEvent {}

class ForNavigation extends ForNavEvent {
  final int index;

  ForNavigation({required this.index});
}
