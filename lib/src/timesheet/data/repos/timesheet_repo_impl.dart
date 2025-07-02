
import 'package:workbench_simple_timesheet_app/src/timesheet/data/datasources/timesheet_local_data_src.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/timesheet/timesheet_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/repos/timesheet_repo.dart';

class TimesheetRepoImpl implements TimesheetRepo {
  const TimesheetRepoImpl(this._localDataSrc);

  final TimesheetLocalDataSrc _localDataSrc;

  @override
  Future<List<People>> getPeopleList() async {
    return await _localDataSrc.getPeopleList();
  }

  @override
  Future<List<Tasks>> getTasksList() async {
    return await _localDataSrc.getTasksList();
  }

  @override
  Future<List<Timesheet>> getTimesheetList() async {
    return await _localDataSrc.getTimesheetList();
  }

  @override
  Future<int> addTimesheet(TimesheetModel data) async{
    return await _localDataSrc.addTimesheet(data: data);
  }

  @override
  Future<int> updateTimesheet(TimesheetModel data) async{
    return await _localDataSrc.updateTimesheet(data: data);
  }

  @override
  Future<List<Timesheet>> searchTimesheet(String query) async {
    return await _localDataSrc.searchTimesheet(query: query);
  }

  @override
  Future<int> deleteTimesheet(int id) async{
    return await _localDataSrc.deleteTimesheet(id: id);
  }
}