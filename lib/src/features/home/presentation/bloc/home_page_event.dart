part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class ChangeTabEvent extends HomePageEvent {
  final int tabIndex;

  ChangeTabEvent({required this.tabIndex});
}
