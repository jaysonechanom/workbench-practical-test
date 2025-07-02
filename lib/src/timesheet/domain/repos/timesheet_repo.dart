
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/timesheet/timesheet_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';

abstract class TimesheetRepo {
  Future<List<People>> getPeopleList();

  Future<List<Tasks>> getTasksList();

  Future<List<Timesheet>> getTimesheetList();

  Future<int> addTimesheet(TimesheetModel data);

  Future<int> updateTimesheet(TimesheetModel data);

  Future<List<Timesheet>> searchTimesheet(String query);

  Future<int> deleteTimesheet(int id);
}