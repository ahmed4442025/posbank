import 'package:posbank/app/extentions.dart';
import 'package:posbank/data/database/db_strings_manager.dart';
import 'package:posbank/data/responses/intrest_response.dart';
import 'package:posbank/data/responses/note_response.dart';
import 'package:posbank/data/responses/user_response.dart';
import 'package:sqflite/sqflite.dart';
import '../database/db_models.dart';
import '../network/app_api.dart';
import '../network/requests.dart';

abstract class RemoteDataSource {
  // GET
  Future<List<NoteResponse>> getAllNotes();

  Future<List<UserResponse>> getAllUsers();

  Future<List<InterestResponse>> getAllInterests();

  // POST

  Future<String> noteUpdate(NoteUpdateRequest noteUpdateRequest);

  Future<String> noteInsert(NoteInsertRequest noteInsertRequest);

  Future<String> userInsert(UserInsertRequest userInsertRequest);
}

class RemoteDataSourceApi implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceApi(this._appServiceClient);

  @override
  Future<List<InterestResponse>> getAllInterests() async {
    return await _appServiceClient.getAllInterests();
  }

  @override
  Future<List<NoteResponse>> getAllNotes() async {
    return await _appServiceClient.getAllNotes();
  }

  @override
  Future<List<UserResponse>> getAllUsers() async {
    return await _appServiceClient.getAllUsers();
  }

  @override
  Future<String> noteInsert(NoteInsertRequest noteInsertRequest) async {
    return await _appServiceClient.notesInsert(noteInsertRequest.text,
        noteInsertRequest.userId, noteInsertRequest.placeDateTime);
  }

  @override
  Future<String> noteUpdate(NoteUpdateRequest noteUpdateRequest) async {
    return await _appServiceClient.notesUpdate(
        noteUpdateRequest.id,
        noteUpdateRequest.text,
        noteUpdateRequest.userId,
        noteUpdateRequest.placeDateTime);
  }

  @override
  Future<String> userInsert(UserInsertRequest userInsertRequest) async {
    return await _appServiceClient.userInsert(
        userInsertRequest.username,
        userInsertRequest.password,
        userInsertRequest.email,
        userInsertRequest.imageAsBase64.orEmpty(),
        userInsertRequest.intrestId);
  }
}

class RemoteDataSourceDB implements RemoteDataSource {
  final Database _database;

  RemoteDataSourceDB(this._database);

  @override
  Future<List<InterestResponse>> getAllInterests() async {
    List<Map<String, dynamic>> res = await _database
        .rawQuery('SELECT * FROM ${DBStringsManager.interestedTable}');
    return res.map((e) => InterestResponse.fromJson(e)).toList();
  }

  @override
  Future<List<NoteResponse>> getAllNotes() async {
    List<Map<String, dynamic>> res = await _database
        .rawQuery('SELECT * FROM ${DBStringsManager.notesTable}');
    return res.map((e) => NoteResponse.fromJson(e)).toList();
  }

  @override
  Future<List<UserResponse>> getAllUsers() async {
    List<Map<String, dynamic>> res = await _database
        .rawQuery('SELECT * FROM ${DBStringsManager.usersTable}');
    return res.map((e) => UserResponse.fromJson(e)).toList();
  }

  @override
  Future<String> noteInsert(NoteInsertRequest noteInsertRequest) async {
    await _database.rawInsert(NoteInsertDB(noteInsertRequest.text,
            noteInsertRequest.userId, noteInsertRequest.placeDateTime)
        .toInsert());
    return "Inserted Successfully";
  }

  @override
  Future<String> noteUpdate(NoteUpdateRequest noteUpdateRequest) async {
    NoteUpdateDB note = NoteUpdateDB(
        noteUpdateRequest.id,
        noteUpdateRequest.text,
        noteUpdateRequest.userId,
        noteUpdateRequest.placeDateTime);
    await _database.rawUpdate(note.toUpdate(), note.toValues());
    return "Update Successfully";
  }

  @override
  Future<String> userInsert(UserInsertRequest userInsertRequest) async {
    await _database.rawInsert(UserInsertDB(
            userInsertRequest.username,
            userInsertRequest.password,
            userInsertRequest.email,
            userInsertRequest.imageAsBase64,
            userInsertRequest.intrestId)
        .toInsert());
    return "Inserted Successfully";
  }
}
