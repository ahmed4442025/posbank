import 'package:dartz/dartz.dart';
import 'package:posbank/domain/entities/user_model.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base/base_usecase.dart';

class GetAllUsersUseCase implements BaseUseCase<void, List<UserModel>> {
  final Repository _repository;

  GetAllUsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserModel>>> execute(void input) async {
    return await _repository.getAllUsers();
  }
}
