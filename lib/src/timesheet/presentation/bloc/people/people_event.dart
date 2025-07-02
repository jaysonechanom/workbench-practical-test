part of 'people_bloc.dart';

@immutable
sealed class PeopleEvent extends Equatable {}

final class OnInitialPeopleLoadEvent extends PeopleEvent {
  OnInitialPeopleLoadEvent();

  @override
  List<Object?> get props => [];
}