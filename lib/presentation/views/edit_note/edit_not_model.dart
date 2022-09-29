
import 'package:posbank/domain/entities/note_model.dart';
import 'package:posbank/domain/usecase/cases/update_note_usecase.dart';
import 'package:posbank/presentation/base/baseviewmodel.dart';
import 'package:posbank/presentation/base/shared.dart';


class EditNoteViewModel extends BaseViewModel
    with EditNoteViewModelInput, EditNoteViewModelOutput {

  final UpdateNoteUseCase updateNoteUseCase;

  EditNoteViewModel(this.updateNoteUseCase);

  NoteModel currentNote = openedNote;

  @override
  start() async {

  }

  @override
  void dispose() {

  }

  void testEdit(){

  }


}

abstract class EditNoteViewModelInput {

}

abstract class EditNoteViewModelOutput {

}