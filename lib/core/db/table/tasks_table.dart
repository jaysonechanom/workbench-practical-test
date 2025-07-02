class TasksTable {
  final String tableName = "tasks";
  final String columnId = "id";
  final String columnName = "name";
  final String columnDescription = "description";
  late final String createTable;

  TasksTable() {
    createTable = "CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnName TEXT NOT NULL,"
        "$columnDescription TEXT NOT NULL"
        ")";
  }
}