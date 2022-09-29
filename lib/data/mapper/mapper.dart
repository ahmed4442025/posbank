import 'package:posbank/app/app_constants.dart';
import 'package:posbank/app/extentions.dart';
import 'package:posbank/data/responses/intrest_response.dart';
import 'package:posbank/data/responses/note_response.dart';
import 'package:posbank/data/responses/user_response.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/entities/user_model.dart';

extension InterestResponseMapper on InterestResponse? {
  InterestModel toDomain() {
    return InterestModel(
        this?.intrestText.orEmpty() ?? "", this?.id.orEmpty() ?? "");
  }
}

extension NoteResponseMapper on NoteResponse? {
  NoteModel toDomain() {
    return NoteModel(
        this?.text.orEmpty() ?? "",
        this?.placeDateTime.orEmpty() ?? "",
        this?.userId.orEmpty() ?? "",
        this?.id.orEmpty() ?? "");
  }
}

extension UserResponseMapper on UserResponse? {
  UserModel toDomain() {
    return UserModel(
        this?.username.orEmpty() ?? "",
        this?.password.orEmpty() ?? "",
        this?.email.orEmpty() ?? "",
        this?.imageAsBase64.orEmpty() ?? AppConstants.image404B64,
        this?.intrestId.orEmpty() ?? "",
        this?.id.orEmpty() ?? "");
  }
}
