part of 'timesheet_bloc.dart';

@immutable
sealed class TimesheetEvent extends Equatable {}

final class OnInitialTimesheetLoadEvent extends TimesheetEvent {
  OnInitialTimesheetLoadEvent();

  @override
  List<Object?> get props => [];
}

final class OnSearchEvent extends TimesheetEvent {
  final String query;
  OnSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}


final class OnDeleteEvent extends TimesheetEvent {
  final int id;
  OnDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}


