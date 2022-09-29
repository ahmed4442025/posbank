import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/utilm/utilm.dart';
import 'package:posbank/presentation/views/note/note_view_model.dart';

import '../../../app/di.dart';
import '../../../domain/entities/note_model.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final NoteHomeViewModel _viewModel = instance<NoteHomeViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<StateType>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return checkState(snapshot.data ?? StateType.loading);
          },
        ));
  }

  Widget checkState(StateType state) {
    switch (state) {
      case StateType.loading:
        return UtilM.loading();
      case StateType.ok:
        return _getContentWidget();
      case StateType.fail:
        return UtilM.fail();
    }
  }

  Widget _getContentWidget() {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.notesAB),
        ),
        body: Column(
          children: [
            const Text("data"),
            StreamBuilder<List<NoteModel>>(
                stream: _viewModel.outputListNotes,
                builder: (context, snapShot) {
                  return Expanded(
                    child: notesList(snapShot.data ?? []),
                  );
                }),
          ],
        ));
  }

  Widget searchRow() => Row();

  Widget notesList(List<NoteModel> notes) => ListView.separated(
      itemBuilder: (c, i) => oneNote(notes[i]),
      separatorBuilder: (c, i) => const Divider(height: 30),
      itemCount: notes.length);

  Widget oneNote(NoteModel note) => Row(
    children: [
      Text(note.text),
      Text("text"),
    ],
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
