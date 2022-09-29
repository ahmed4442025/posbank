import 'dart:async';
import 'dart:ffi';
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';
import 'package:posbank/domain/usecase/cases/update_note_usecase.dart';
import 'package:posbank/presentation/base/baseviewmodel.dart';
import 'package:posbank/presentation/base/shared.dart';

import '../../../domain/entities/user_model.dart';
import '../../../domain/usecase/cases/get_all_users_usecase.dart';
import '../note/note_view_model.dart';

class EditNoteViewModel extends BaseViewModel
    with EditNoteViewModelInput, EditNoteViewModelOutput {
  // init
  final UpdateNoteUseCase updateNoteUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  EditNoteViewModel(this.updateNoteUseCase, this.getAllUsersUseCase);

  // vars
  List<UserModel> users = [];

  // streams
  final StreamController _usersStatSC = StreamController<StateType>.broadcast();

  @override
  Sink get inputUsersState => _usersStatSC.sink;

  @override
  Stream<StateType> get outputUsersState =>
      _usersStatSC.stream.map((state) => state);

  final StreamController _saveStatSC = StreamController<StateType>.broadcast();
  @override
  Sink get inputSaveState => _saveStatSC.sink;

  @override
  Stream<StateType> get outputSaveState => _saveStatSC.stream.map((state) => state);

  // voids

  NoteModel currentNote = openedNote;

  @override
  start() async {
    _loadData();
  }

  @override
  void dispose() {
    _usersStatSC.close();
    _saveStatSC.close();
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    NoteUpdateUCInput newNote =
        NoteUpdateUCInput(note.id, note.text, note.userId, note.placeDateTime);
    (await updateNoteUseCase.execute(newNote)).fold(
      (failure) {
        inputUsersState.add(StateType.fail);
      },
      (u) async {
        inputUsersState.add(StateType.ok);
        print("ok save");
      },
    );
  }

  // privet voids

  _loadData() async {
    inputUsersState.add(StateType.loading);
    (await getAllUsersUseCase.execute(Void)).fold(
      (failure) {
        inputUsersState.add(StateType.fail);
      },
      (u) async {
        inputUsersState.add(StateType.ok);
        users = u;
      },
    );
  }


}

abstract class EditNoteViewModelInput {
  Sink get inputUsersState;
  Sink get inputSaveState;

  void updateNote(NoteModel note);
}

abstract class EditNoteViewModelOutput {
  Stream<StateType> get outputUsersState;
  Stream<StateType> get outputSaveState;
}
