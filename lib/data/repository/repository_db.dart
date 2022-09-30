import 'package:dartz/dartz.dart';
import 'package:posbank/data/network/failure.dart';
import 'package:posbank/data/network/requests.dart';
import 'package:posbank/data/responses/user_response.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/entities/user_model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import 'package:posbank/data/mapper/mapper.dart';

class RepositoryDB implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryDB(this._remoteDataSource,);

  // =========== get All Interests =============
  @override
  Future<Either<Failure, List<InterestModel>>> getAllInterests() async {
    try {
      final response = await _remoteDataSource.getAllInterests();
      return Right(response.map((interest) => interest.toDomain()).toList());
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }

  // =========== get All Notes =============
  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      final response = await _remoteDataSource.getAllNotes();
      return Right(response.map((note) => note.toDomain()).toList());
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }


// =========== get All Users =============
  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final response = await _remoteDataSource.getAllUsers();
      return Right(
          response.map((UserResponse user) => user.toDomain()).toList());
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }

// =========== note insert =============
  @override
  Future<Either<Failure, String>> noteInsert(
      NoteInsertRequest noteInsertRequest) async {
    try {
      final response = await _remoteDataSource.noteInsert(noteInsertRequest);
      if (response == ApiInternalStatus.success_insert) {
        // success --> return either right --> return data
        return Right(response);
      } else {
        // failure --> return business error
        return Left(Failure(ApiInternalStatus.FAILURE, response));
      }
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }

// =========== note Update =============
  @override
  Future<Either<Failure, String>> noteUpdate(
      NoteUpdateRequest noteUpdateRequest) async {
    try {
      final response = await _remoteDataSource.noteUpdate(noteUpdateRequest);
      if (response == ApiInternalStatus.success_update) {
        // success --> return either right --> return data
        return Right(response);
      } else {
        // failure --> return business error
        return Left(Failure(ApiInternalStatus.FAILURE, response));
      }
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }

// =========== user insert =============
  @override
  Future<Either<Failure, String>> userInsert(
      UserInsertRequest userInsertRequest) async {
    try {
      final response = await _remoteDataSource.userInsert(userInsertRequest);
      if (response == ApiInternalStatus.success_insert) {
        // success --> return either right --> return data
        return Right(response);
      } else {
        // failure --> return business error
        return Left(Failure(ApiInternalStatus.FAILURE, response));
      }
    } catch (error) {
      return Left(Failure(-1, "db error"));
    }
  }
}