import 'package:dartz/dartz.dart';
import 'package:posbank/data/network/requests.dart';
import 'package:posbank/data/responses/note_response.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/entities/user_model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  // GET
  Future<Either<Failure, List<NoteModel>>> getAllNotes();

  Future<Either<Failure, List<UserModel>>> getAllUsers();

  Future<Either<Failure, List<InterestModel>>> getAllInterests();

  // POST
  Future<Either<Failure, String>> noteUpdate(
      NoteUpdateRequest noteUpdateRequest);

  Future<Either<Failure, String>> noteInsert(
      NoteInsertRequest noteInsertRequest);

  Future<Either<Failure, String>> userInsert(
      UserInsertRequest userInsertRequest);
}
