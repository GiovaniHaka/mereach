import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  String tableServer = 'servers';
  String columnId = 'id';
  String columnUrl = 'url';
  String columnUpdatedAt = 'updatedAt';
  static String databaseName = 'petowner.db';

  Future<Database> databaseServers() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, databaseName),
      onCreate: (db, version) {
        db.execute(
          createServersTable(),
        );
        print("DB iniciado pela primeira vez!");
      },
      version: 1,
    );
  }

  String createServersTable() {
    return '''CREATE TABLE $tableServer (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnUrl TEXT,
          $columnUpdatedAt TEXT
      )
    ''';
  }

  Future close() async {
    final db = await databaseServers();
    db.close();
  }

  Future<List<Map>> getServers() async {
    try {
      final db = await databaseServers();
      List<Map> servers = await db.query(
        tableServer,
      );
      return servers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> insertServer(String serverUrl) async {
    try {
      final db = await databaseServers();
      await db.insert(
        tableServer,
        {
          columnUrl: serverUrl,
          columnUpdatedAt: DateTime.now().toUtc().toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteServer(int id) async {
    try {
      final db = await databaseServers();
      await db.delete(
        tableServer,
        where: '$columnId = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }
}
