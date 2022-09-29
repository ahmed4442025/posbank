import 'dart:io';

import '../note/note_view_model.dart';

abstract class AddUserViewModelInput {
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputEmail;

  Sink get inputInterestedId;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  addUser();

  setUserName(String userName);

  setPassword(String password);

  setEmail(String email);

  setInterestedId(String interestedId);

  setProfilePicture(File profilePicture);

  Sink get inputInterestedState;

  Sink get inputSaveState;
}

abstract class AddUserViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;

  Stream<StateType> get outputInterestedState;

  Stream<StateType> get outputSaveState;
}
