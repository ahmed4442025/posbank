import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posbank/presentation/base/shared.dart';
import 'package:posbank/presentation/resources/color_manager.dart';
import 'package:posbank/presentation/resources/icons_manager.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/resources/values_manager.dart';
import 'package:posbank/presentation/resources/views_manager.dart';
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
  TextEditingController searchCtrl = TextEditingController();
  bool showSearchField = true;

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
    searchCtrl.addListener(() => _viewModel.searchByKey(searchCtrl.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.notesAB),
          leading: const SizedBox.shrink(),
          actions: [
            SizedBox(
                width: 40,
                child: InkWell(
                    onTap: () {
                      ViewsManager.openAddUserWB(context);
                    },
                    child: Icon(IconsManager.addUser))),
            SizedBox(
                width: 40,
                child: InkWell(
                    onTap: () {
                      ViewsManager.openOptionsWB(context);
                    },
                    child: Icon(IconsManager.options))),
            SizedBox(
                width: 40,
                child: InkWell(
                    onTap: () {
                      // todo
                    },
                    child: Icon(IconsManager.list))),
          ],
        ),
        // FloatingActionButton
        floatingActionButton: FloatingActionButton(
            onPressed: () => _viewModel.addNote(),
            child: const Icon(IconsManager.add)),
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
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: [
          searchRow(),
          UtilM.box20(),
          Expanded(child: notesList(_viewModel.listModel)),
        ],
      ),
    );
  }

  // search and filter
  Widget searchRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
        child: Row(
          children: [
            InkWell(
              onTap: () => _viewModel.searchByUserId("1"),
              child: const Icon(
                IconsManager.filterList,
                color: ColorManager.primary,
              ),
            ),
            UtilM.box10(),
            InkWell(
              onTap: () {
                showSearchField = !showSearchField;
                setState(() {});
              },
              child: const Icon(
                IconsManager.search,
                color: ColorManager.primary,
              ),
            ),
            UtilM.box10(),
            // text field search
            if (showSearchField)
              Expanded(
                  child: SizedBox(
                      height: AppSize.s40,
                      child: TextField(
                        controller: searchCtrl,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () => searchCtrl.text = "",
                              child: const Icon(IconsManager.x)),
                        ),
                      )))
          ],
        ),
      );

  // all notes
  Widget notesList(List<NoteModel> notes) => ListView.separated(
      itemBuilder: (c, i) => oneNote(notes[i], context),
      separatorBuilder: (c, i) => const Divider(height: 30),
      itemCount: notes.length);

  // one note
  Widget oneNote(NoteModel note, context) => Row(
        children: [
          Expanded(
            child: Text(
              note.text,
              maxLines: 2,
            ),
          ),
          UtilM.box15(),
          InkWell(
            onTap: () =>
                {ViewsManager.openEditNoteWB(context), openedNote = note},
            child: const Icon(
              IconsManager.edit,
              color: ColorManager.grey,
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
