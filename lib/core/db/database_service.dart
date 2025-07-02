
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'database_helper.dart';
import 'database_interface.dart';

class DatabaseService extends DatabaseInterface<Map<String, dynamic>> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Future<int?> delete({required String tableName,
    required String whereClause, required List<dynamic> whereArgs}) async {
    try {
      final Database database = await databaseHelper.database;
      return await database.delete(
        tableName,
        where: whereClause,
        whereArgs: whereArgs,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> get({required String tableName,
    required String whereClause, required List<dynamic> whereArgs}) async {
    try {
      final Database database = await databaseHelper.database;
      final List<Map<String, dynamic>> cursor = await database.query(tableName,
          where: whereClause, whereArgs: whereArgs);

      if (cursor.isNotEmpty) {
        return cursor.first;
      } else {
        throw Error();
      }
    } catch(_) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll({required String tableName,
    required String columnId, String? whereClause, List<dynamic>? whereArgs}) async {
    try {
      final Database database = await databaseHelper.database;
      late List<Map<String, dynamic>> result;
      if(whereClause != null && whereArgs != null) {
        result = await database.query(
          tableName,
          orderBy: "$columnId DESC",
        );
      } else {
        result = await database.query(
          tableName,
          where: whereClause,
          whereArgs: whereArgs,
          orderBy: "$columnId DESC",
        );
      }

      return result;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<int?> insert({required String tableName,
    required Map<String, dynamic> data}) async {
    try {
      final Database database = await databaseHelper.database;
      return await database.insert(tableName, data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> update({required String tableName,
    required Map<String, dynamic> data, required String whereClause,
    required List whereArgs}) async {
    try {
      final Database database = await databaseHelper.database;
      return await database.update(tableName, data,
          where: whereClause, whereArgs: whereArgs);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getRawQuery({required String query}) async {
    try {
      final Database database = await databaseHelper.database;
      return await database.rawQuery(query);
    } catch (e) {
      return [];
    }
  }
}