import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'for_nav_event.dart';
part 'for_nav_state.dart';

class ForNavBloc extends Bloc<ForNavEvent, ForNavState> {
  ForNavBloc() : super(ForNavInitial()) {
    on<ForNavigation>((event, emit) {
      return emit(ForNavState(index: event.index));
    });
  }
}
