import 'package:posbank/app/extentions.dart';
import 'package:posbank/data/responses/intrest_response.dart';
import 'package:posbank/data/responses/note_response.dart';
import 'package:posbank/data/responses/user_response.dart';
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
