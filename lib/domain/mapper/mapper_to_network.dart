import 'package:posbank/data/network/requests.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';

extension NoteInsertUCInputMapper on NoteInsertUCInput {
  NoteInsertRequest toNetwork() {
    return NoteInsertRequest(text, userId, placeDateTime);
  }
}

extension NoteUpdateUCInputMapper on NoteUpdateUCInput {
  NoteUpdateRequest toNetwork() {
    return NoteUpdateRequest(userId, text, userId, placeDateTime);
  }
}

extension UserInsertUCInputMapper on UserInsertUCInput {
  UserInsertRequest toNetwork() {
    return UserInsertRequest(
        username, password, email, imageAsBase64, intrestId);
  }
}
