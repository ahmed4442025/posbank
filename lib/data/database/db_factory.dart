import 'package:posbank/data/database/db_strings_manager.dart';
import 'package:sqflite/sqflite.dart';

import 'db_models.dart';

class DBFactory {
  Future<Database> getDB() async {
    late Database database;
    await openDatabase(DBStringsManager.dbName, version: 1,
        onCreate: (db, version) async {
      print('db created');

      String usersQ = _createUsersTableQuery();
      String notesQ = _createNotesTableQuery();
      String interestedQ = _createInterestedTableQuery();

      // create users
      await db.execute(usersQ).then((value) {
        print('users table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });

      // create notes
      await db.execute(notesQ).then((value) {
        print('notes table created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });

      // create interested
      await db.execute(interestedQ).then((value) {
        print('interested created');
      }).catchError((error) {
        print('ERROR when creating table ${error.toString()}');
      });

      // insert default
      await interestedDefaultValue(db);
    }, onOpen: (db) async {
      database = db;
    });
    return database;
  }

  String _createUsersTableQuery() {
    return 'CREATE TABLE ${DBStringsManager.usersTable}'
        ' ('
        '${DBStringsManager.usersId} INTEGER PRIMARY KEY,'
        ' ${DBStringsManager.usersUsername} TEXT,'
        ' ${DBStringsManager.usersPassword} TEXT,'
        ' ${DBStringsManager.usersEmail} TEXT,'
        ' ${DBStringsManager.usersImageAsBase64} TEXT,'
        ' ${DBStringsManager.usersIntrestId} TEXT'
        ' )';
  }

  String _createNotesTableQuery() {
    return 'CREATE TABLE ${DBStringsManager.notesTable}'
        ' ('
        '${DBStringsManager.notesId} INTEGER PRIMARY KEY,'
        ' ${DBStringsManager.notesText} TEXT,'
        ' ${DBStringsManager.notesPlaceDateTime} TEXT,'
        ' ${DBStringsManager.notesUserId} TEXT'
        ' )';
  }

  String _createInterestedTableQuery() {
    return 'CREATE TABLE ${DBStringsManager.interestedTable}'
        ' ('
        '${DBStringsManager.interestedId} INTEGER PRIMARY KEY,'
        ' ${DBStringsManager.interestedText} TEXT'
        ' )';
  }

  Future<void> interestedDefaultValue(Database db) async {
    await db
        .rawInsert(InterestedInsertDB("Swimming").toInsert())
        .catchError((error) {});
    await db
        .rawInsert(InterestedInsertDB("Football").toInsert())
        .catchError((error) {});
    await db
        .rawInsert(InterestedInsertDB("Programming").toInsert())
        .then((value) => print("insert interested"))
        .catchError((error) {
      print("error inserting$error");
    });
  }
}
