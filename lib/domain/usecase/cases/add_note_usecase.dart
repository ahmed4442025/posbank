import 'package:dartz/dartz.dart';
import 'package:posbank/domain/mapper/mapper_to_network.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base/base_usecase.dart';

class AddNoteUseCase implements BaseUseCase<NoteInsertUCInput, String> {
  final Repository _repository;

  AddNoteUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(NoteInsertUCInput input) async {
    return await _repository.noteInsert(input.toNetwork());
  }
}
