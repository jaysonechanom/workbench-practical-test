import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/people_table.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/tasks_table.dart';
import 'package:workbench_simple_timesheet_app/core/db/table/time_entries_table.dart';
import 'package:workbench_simple_timesheet_app/core/utils/env_config.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  final int version = 1;
  String? path;
  Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() {
    return _instance;
  }

  ///*
  ///Database instance asynchronously
  Future<Database> get database async {
    _database ??= await init(EnvConfig().getValue(EnvConfig.localDbName),
        EnvConfig().getValue(EnvConfig.localDbPassword));

    return _database!;
  }

  ///*
  ///Database configuration
  Future<Database> init(String dbName, String dbPassword) async {
    if (_database != null) return _database!;
    final String dbPath = await getDatabasesPath();
    path = join(dbPath, dbName);

    return await openDatabase(
        path!,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        version: version,
        password: dbPassword
    );
  }

  ///*
  ///Create tables and initial schema
  Future<void> onCreate(Database db, int version) async {
    await db.execute(PeopleTable().createTable);
    await db.execute(TasksTable().createTable);
    await db.execute(TimeEntriesTable().createTable);

    ///sample people data
    await db.insert('people', {'fullName': 'Alice Smith'});
    await db.insert('people', {'fullName': 'Bob Johnson'});
    await db.insert('people', {'fullName': 'Charlie Davis'});

    ///sample tasks data
    await db.insert('tasks', {'name': 'Buy groceries', 'description': 'Milk, Eggs, Bread, and Coffee'});
    await db.insert('tasks', {'name': 'Workout', 'description': 'Cardio and strength training for 1 hour'});
    await db.insert('tasks', {'name': 'Read Flutter docs', 'description': 'Focus on state management techniques'});
    await db.insert('tasks', {'name': 'Clean workspace', 'description': 'Organize desk and dispose of trash'});
    await db.insert('tasks', {'name': 'Team meeting', 'description': 'Project planning and sprint discussion'});
    await db.insert('tasks', {'name': 'Write blog post', 'description': 'Topic: Flutter vs React Native'});
    await db.insert('tasks', {'name': 'Fix login bug', 'description': 'Resolve issue with email/password login'});
    await db.insert('tasks', {'name': 'Grocery delivery', 'description': 'Confirm schedule and payment'});
    await db.insert('tasks', {'name': 'Check emails', 'description': 'Reply to support tickets and inquiries'});
    await db.insert('tasks', {'name': 'Plan weekend trip', 'description': 'Research locations and hotel bookings'});
  }

  ///*
  ///Handling database version upgrades
  ///Apply the update based on the version number of database
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    while(oldVersion < newVersion){
      oldVersion++;

      switch(oldVersion){
        case 2:
          break;
      }
    }
  }

  ///*
  ///Add columns on database upgrade
  Future<void> addColumn(String tableName, String columnName, String dataType, Database db) async {
    final List<Map<String,dynamic>> result = await db.rawQuery('PRAGMA table_info($tableName)');

    if(result.isNotEmpty){
      for(Map<String,dynamic> existingColumn in result){
        if(existingColumn['name'] == columnName){
          return;
        }
      }

      final sqlAlter = "ALTER TABLE $tableName ADD COLUMN $columnName $dataType";
      await db.execute(sqlAlter);
    }
    else{
      return;
    }
  }

  ///*
  ///Delete SQLite database when needed
  Future<void> deleteDb() async {
    if (_database != null && _database!.isOpen) {
      await _database?.close();
    }
    await deleteDatabase(path ?? join(
        await getDatabasesPath(),
        EnvConfig().getValue(EnvConfig.localDbName)
    ));
    _database = null;
    path = null;
  }
}