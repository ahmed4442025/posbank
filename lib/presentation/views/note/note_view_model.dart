import 'dart:async';
import 'dart:ffi';

import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/usecase/base/use_case_models.dart';
import 'package:posbank/domain/usecase/cases/add_note_usecase.dart';
import 'package:posbank/domain/usecase/cases/get_all_notes_usecase.dart';
import 'package:posbank/presentation/base/baseviewmodel.dart';

import '../../utilm/toast_manager.dart';

class NoteHomeViewModel extends BaseViewModel
    with NoteHomeViewModelInput, NoteHomeViewModelOutput {
  List<NoteModel> listModel = [];

  // ========== streams ==========
  final StreamController _listNotesSC =
      StreamController<List<NoteModel>>.broadcast();
  final StreamController _stateSC = StreamController<StateType>.broadcast();

  final GetAllNotesUseCase getAllNotesUseCase;
  final AddNoteUseCase addNoteUseCase;

  NoteHomeViewModel(this.getAllNotesUseCase, this.addNoteUseCase);

  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(StateType.loading);
    (await getAllNotesUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(StateType.fail);
      },
      (notes) async {
        inputState.add(StateType.ok);
        print(notes[0].text);
        print(notes.length);
        listModel = notes;
        inputListNotes.add(listModel);
      },
    );
  }

  @override
  void dispose() {
    _listNotesSC.close();
    _stateSC.close();
  }

  // ========== streams ==========
  @override
  Sink get inputListNotes => _listNotesSC.sink;

  @override
  Sink get inputState => _stateSC.sink;

  @override
  Stream<List<NoteModel>> get outputListNotes => _listNotesSC.stream.map((l) {
        print("l : $l");
        return l;
      });

  @override
  Stream<StateType> get outputState => _stateSC.stream.map((state) {
        print("state : $state");
        return state;
      });

  // ============ voids =============
  @override
  addNote() async {
    NoteInsertUCInput note = NoteInsertUCInput("text", '101', "placeDateTime");
    (await addNoteUseCase.execute(note)).fold(
        (l) => ToastManager.toastOk(l.message),
        (r) => ToastManager.toastOk(r));
  }

  @override
  search(String key) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  setCurrentNote(NoteModel note) {
    // TODO: implement setCurrentNote
    throw UnimplementedError();
  }
}

abstract class NoteHomeViewModelInput {
  search(String key);

  addNote();

  setCurrentNote(NoteModel note);

  Sink get inputListNotes;

  Sink get inputState;
}

abstract class NoteHomeViewModelOutput {
  Stream<List<NoteModel>> get outputListNotes;

  Stream<StateType> get outputState;
}

enum StateType { loading, ok, fail }
