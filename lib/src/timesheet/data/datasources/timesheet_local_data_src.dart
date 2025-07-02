
import 'package:workbench_simple_timesheet_app/core/db/database_service.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/people_table.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/tasks_table.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/time_entries_table.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/people/people_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/tasks/tasks_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/timesheet/timesheet_model.dart';

class TimesheetLocalDataSrc extends DatabaseService {
  final PeopleTable _peopleTable = PeopleTable();
  final TasksTable _tasksTable = TasksTable();
  final TimeEntriesTable _timesheet = TimeEntriesTable();

  Future<List<PeopleModel>> getPeopleList() async {
    final result = await getAll(
        tableName: _peopleTable.tableName,
        columnId: _peopleTable.columnId
    );
    return result.isNotEmpty
        ? result.map((e) => PeopleModel.fromMap(e)).toList()
        : [];
  }

  Future<List<TasksModel>> getTasksList() async {
    final result = await getAll(
        tableName: _tasksTable.tableName,
        columnId: _tasksTable.columnId
    );
    return result.isNotEmpty
        ? result.map((e) => TasksModel.fromMap(e)).toList()
        : [];
  }

  Future<List<TimesheetModel>> getTimesheetList() async {
    final result = await getRawQuery(
        query: '''
          SELECT 
            t.id,
            t.date,
            t.startTime,
            t.endTime,
            t.notes,
            t.peopleId,
            t.tasksId,
            p.fullName as personName,
            ts.name as taskName,
            ts.description as taskDescription
          FROM timeEntries t
          JOIN people p ON t.peopleId = p.id
          JOIN tasks ts ON t.tasksId = ts.id
          ORDER BY t.id DESC
        ''');
    return result.isNotEmpty
        ? result.map((e) => TimesheetModel.fromMap(e)).toList()
        : [];
  }

  Future<int> addTimesheet({required TimesheetModel data}) async {
    return await insert(
        tableName: _timesheet.tableName,
        data: data.toJson()) ?? -1;
  }

  Future<int> updateTimesheet({required TimesheetModel data}) async {
    return await update(
        tableName: _timesheet.tableName,
        data: data.toJson(),
        whereClause: '${_timesheet.columnId} = ?',
        whereArgs: [data.id]) ?? -1;
  }

  Future<List<TimesheetModel>> searchTimesheet({required String query}) async {
    final result = await getRawQuery(
        query: '''
          SELECT 
            t.id,
            t.date,
            t.startTime,
            t.endTime,
            t.notes,
            t.peopleId,
            t.tasksId,
            p.fullName AS personName,
            ts.name AS taskName,
            ts.description AS taskDescription
          FROM timeEntries t
          JOIN people p ON t.peopleId = p.id
          JOIN tasks ts ON t.tasksId = ts.id
          WHERE 
            p.fullName LIKE '%$query%' OR 
            ts.name LIKE '%$query%' OR 
            t.date LIKE '%$query%'
          ORDER BY t.id DESC
        '''
        );

    return result.isNotEmpty
        ? result.map((e) => TimesheetModel.fromMap(e)).toList()
        : [];
  }

  Future<int> deleteTimesheet({required int id}) async {
    return await delete(
        tableName: _timesheet.tableName,
        whereClause: '${_timesheet.columnId} = ?',
        whereArgs: [id]) ?? -1;
  }

}