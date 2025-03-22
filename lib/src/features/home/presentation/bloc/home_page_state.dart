part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {
  final int tabIndex;
  const HomePageState({required this.tabIndex});
}

final class HomePageInitial extends HomePageState {
  const HomePageInitial({required super.tabIndex});
}
