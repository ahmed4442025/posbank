import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';
import 'package:posbank/domain/usecase/cases/add_user_usecase.dart';
import 'package:posbank/domain/usecase/cases/get_all_interests_usecase.dart';
import 'package:posbank/presentation/base/baseviewmodel.dart';
import 'package:posbank/presentation/views/note/note_view_model.dart';
import 'add_user_abstracts.dart';

class AddUserViewModel extends BaseViewModel
    with AddUserViewModelInput, AddUserViewModelOutput {
  // init
  final GetAllInterestsUseCase getAllInterestsUseCase;
  final AddUserUseCase addUserUseCase;

  AddUserViewModel(this.getAllInterestsUseCase, this.addUserUseCase);

  UserInsertUCInput registerObject = UserInsertUCInput("", "", "", "", "");
  List<InterestModel> listInter = [];

  // streams

  StreamController emailSC = StreamController<String>.broadcast();
  StreamController userNameSC = StreamController<String>.broadcast();
  StreamController passwordSC = StreamController<String>.broadcast();
  StreamController interestedSC = StreamController<String>.broadcast();
  StreamController profilePictureSC = StreamController<File>.broadcast();
  StreamController areAllInputsValidSC = StreamController<void>.broadcast();
  StreamController isUserRegisteredInSuccessfullySC = StreamController<bool>();
  final StreamController _interestedStatSC =
      StreamController<StateType>.broadcast();
  final StreamController _saveStatSC = StreamController<StateType>.broadcast();

  // stream Inputs
  @override
  Sink get inputAllInputsValid => areAllInputsValidSC.sink;

  @override
  Sink get inputEmail => emailSC.sink;

  @override
  Sink get inputInterestedId => interestedSC.sink;

  @override
  Sink get inputPassword => passwordSC.sink;

  @override
  Sink get inputProfilePicture => profilePictureSC.sink;

  @override
  Sink get inputUserName => userNameSC.sink;

  @override
  Sink get inputInterestedState => _interestedStatSC.sink;

  @override
  Sink get inputSaveState => _saveStatSC.sink;

  // streams OutPuts
  @override
  Stream<bool> get outputIsUserNameValid => userNameSC.stream.map((userName) {
        return _isUserNameValid(userName);
      });

  @override
  Stream<bool> get outputIsEmailValid => emailSC.stream.map((email) {
        return _isEmailValid(email);
      });

  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordSC.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<File> get outputProfilePicture =>
      profilePictureSC.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidSC.stream.map((event) => _areAllInputsValid());

  @override
  Stream<StateType> get outputInterestedState =>
      _interestedStatSC.stream.map((state) => state);

  @override
  Stream<StateType> get outputSaveState =>
      _saveStatSC.stream.map((state) => state);

  // voids
  @override
  void start() {
    _loadData();
  }

  @override
  void dispose() {
    emailSC.close();
    userNameSC.close();
    passwordSC.close();
    interestedSC.close();
    profilePictureSC.close();
    areAllInputsValidSC.close();
    isUserRegisteredInSuccessfullySC.close();
    _saveStatSC.close();
    _interestedStatSC.close();
  }

  @override
  addUser() async {
    _saveStatSC.add(StateType.loading);
    (await addUserUseCase.execute(registerObject)).fold(
      (failure) {
        _saveStatSC.add(StateType.fail);
      },
      (u) async {
        _saveStatSC.add(StateType.ok);
      },
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerObject.email = email;
    } else {
      registerObject.email = "";
    }
    validate();
  }

  @override
  setInterestedId(String interestedId) {
    registerObject.intrestId = interestedId;
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject.password = password;
    } else {
      registerObject.password = "";
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      final bytes = profilePicture.readAsBytesSync();
      String img64 = base64Encode(bytes);
      registerObject.imageAsBase64 = img64;
      inputProfilePicture.add(profilePicture);
    }
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject.username = userName;
    } else {
      registerObject.username = "";
    }
    validate();
  }

  // --  private functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 4;
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(password);
  }

  bool _areAllInputsValid() {
    return registerObject.username.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.intrestId.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }

  _loadData() async {
    inputInterestedState.add(StateType.loading);
    (await getAllInterestsUseCase.execute(Void)).fold(
      (failure) {
        inputInterestedState.add(StateType.fail);
      },
      (u) async {
        inputInterestedState.add(StateType.ok);
        listInter = u;
      },
    );
  }
}
