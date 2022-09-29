import 'package:dartz/dartz.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/entities/user_model.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base/base_usecase.dart';

class GetAllInterestsUseCase implements BaseUseCase<void, List<InterestModel>> {
  final Repository _repository;

  GetAllInterestsUseCase(this._repository);

  @override
  Future<Either<Failure, List<InterestModel>>> execute(void input) async {
    return await _repository.getAllInterests();
  }
}
