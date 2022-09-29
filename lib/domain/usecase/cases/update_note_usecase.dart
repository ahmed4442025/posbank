import 'package:dartz/dartz.dart';
import 'package:posbank/domain/mapper/mapper_to_network.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base/base_usecase.dart';

class UpdateNoteUseCase implements BaseUseCase<NoteUpdateUCInput, String> {
  final Repository _repository;

  UpdateNoteUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(NoteUpdateUCInput input) async {
    return await _repository.noteUpdate(input.toNetwork());
  }
}
