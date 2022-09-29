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
  List<NoteModel> listAllModel = [];

  // ========== streams ==========
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
        listAllModel = notes;
      },
    );
  }

  @override
  void dispose() {
    _stateSC.close();
  }

  // ========== streams ==========

  @override
  Sink get inputState => _stateSC.sink;

  @override
  Stream<StateType> get outputState => _stateSC.stream.map((state) {
        print("state : $state");
        return state;
      });

  // ============ voids =============
  @override
  addNote() async {
    NoteInsertUCInput note =
        NoteInsertUCInput("text", '101', "2021-11-18T09:39:44");
    (await addNoteUseCase.execute(note))
        .fold((l) => ToastManager.toastOk(l.message), (r) {
      ToastManager.toastOk(r);
      _loadData();
    });
  }

  @override
  searchByKey(String keySearch) {
    listModel = listAllModel.where((note) {
      String noteText = note.text.toLowerCase();
      keySearch = keySearch.toLowerCase();
      return noteText.contains(keySearch);
    }).toList();
    _stateSC.add(StateType.ok);
  }

  @override
  searchByUserId(String userId) {
    listModel = listAllModel.where((note) {
      return note.id == userId;
    }).toList();
    _stateSC.add(StateType.ok);
  }
}

abstract class NoteHomeViewModelInput {
  searchByKey(String keySearch);

  searchByUserId(String userId);

  addNote();

  Sink get inputState;
}

abstract class NoteHomeViewModelOutput {
  Stream<StateType> get outputState;
}

enum StateType { loading, ok, fail }
