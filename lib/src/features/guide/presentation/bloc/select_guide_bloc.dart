import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_guide_event.dart';
part 'select_guide_state.dart';

class SelectGuideBloc extends Bloc<SelectGuideEvent, SelectGuideState> {
  SelectGuideBloc() : super(SelectGuideInitial()) {
    on<SelectGuideEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
