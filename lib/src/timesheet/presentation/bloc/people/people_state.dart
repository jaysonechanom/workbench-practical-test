part of 'people_bloc.dart';

@immutable
sealed class PeopleState extends Equatable {}

final class PeopleInitial extends PeopleState {
  @override
  List<Object?> get props => [];
}

final class PeopleLoading extends PeopleState {
  @override
  List<Object?> get props => [];
}

final class PeopleSuccess extends PeopleState {
  PeopleSuccess(this.people);
  final List<People> people;

  @override
  List<Object?> get props => [people];
}

final class PeopleError extends PeopleState {
  PeopleError(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}