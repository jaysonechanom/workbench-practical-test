class PeopleTable {
  final String tableName = "people";
  final String columnId = "id";
  final String columnFullName = "fullName";
  late final String createTable;

  PeopleTable() {
    createTable = "CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnFullName TEXT NOT NULL"
        ")";
  }
}