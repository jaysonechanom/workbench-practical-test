abstract class DatabaseInterface<T> {
  ///*
  ///Insert record
  Future<int?> insert(
      {required String tableName,
        required Map<String, dynamic> data});

  ///*
  ///Update record record
  Future<int?> update(
      {required String tableName,
        required Map<String, dynamic> data,
        required String whereClause,
        required List<dynamic> whereArgs});

  ///*
  ///Get record
  Future<T?> get(
      {required String tableName,
        required String whereClause,
        required List<dynamic> whereArgs});

  ///*
  ///Get all records
  Future<List<T>> getAll({required String tableName,
    required String columnId, String? whereClause, List<dynamic>? whereArgs});

  ///*
  ///Delete record
  Future<int?> delete(
      {required String tableName,
        required String whereClause,
        required List<dynamic> whereArgs});

  ///*
  ///Get records for raw query
  Future<List<T>> getRawQuery({required String query});

}
