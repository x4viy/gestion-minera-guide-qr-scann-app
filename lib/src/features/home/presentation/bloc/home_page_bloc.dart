import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial(tabIndex: 1)) {
    on<ChangeTabEvent>(_onChangeTab);
  }

  void _onChangeTab(
    ChangeTabEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomePageInitial(tabIndex: event.tabIndex));
  }
}
