import 'package:dartz/dartz.dart';
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/entities/user_model.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base/base_usecase.dart';

class GetAllNotesUseCase implements BaseUseCase<void, List<NoteModel>> {
  final Repository _repository;

  GetAllNotesUseCase(this._repository);

  @override
  Future<Either<Failure, List<NoteModel>>> execute(void input) async {
    return await _repository.getAllNotes();
  }
}
