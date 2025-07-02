class TimeEntriesTable {
  final String tableName = "timeEntries";
  final String columnId = "id";
  final String columnPeopleId = "peopleId";
  final String columnTasksId = "tasksId";
  final String columnDate = "date";
  final String columnStartTime = "startTime";
  final String columnEndTime = "endTime";
  final String columnNotes = "notes";
  late final String createTable;

  TimeEntriesTable() {
    createTable = "CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnPeopleId INTEGER,"
        "$columnTasksId INTEGER,"
        "$columnDate TEXT NOT NULL,"
        "$columnStartTime TEXT NOT NULL,"
        "$columnEndTime TEXT NOT NULL,"
        "$columnNotes TEXT"
        ")";
  }
}