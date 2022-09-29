import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posbank/domain/entities/user_model.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/utilm/utilm.dart';
import 'package:posbank/presentation/views/edit_note/edit_not_model.dart';
import 'package:posbank/presentation/views/note/note_view_model.dart';
import '../../../../app/di.dart';
import '../../resources/icons_manager.dart';
import '../../resources/values_manager.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({Key? key}) : super(key: key);

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  final EditNoteViewModel _viewModel = instance<EditNoteViewModel>();

  TextEditingController noteCtrl = TextEditingController();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
    noteCtrl = TextEditingController(text: _viewModel.currentNote.text);
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.notesAB),
          actions: [
            SizedBox(
                width: 50,
                child: InkWell(
                    onTap: () {
                      _viewModel.currentNote.text = noteCtrl.text;
                      _viewModel.currentNote.userId = currentUser?.id ?? "-1";
                      _viewModel.updateNote(_viewModel.currentNote);
                    },
                    child: const Icon(IconsManager.save)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              //const  note
              TextField(
                decoration: const InputDecoration(
                    label: Text(StringsManager.note),
                    contentPadding: EdgeInsets.all(AppPadding.p16)),
                controller: noteCtrl,
                maxLines: 8,
              ),
              // users
              UtilM.box20(),
              StreamBuilder<StateType>(
                  stream: _viewModel.outputUsersState,
                  builder: (context, snapshot) {
                    return checkState(snapshot.data ?? StateType.loading);
                  })
            ],
          ),
        ));
  }

  Widget checkState(StateType state) {
    switch (state) {
      case StateType.loading:
        return UtilM.loading();
      case StateType.ok:
        return dropDown(_viewModel.users);
      case StateType.fail:
        return UtilM.fail();
    }
  }

  UserModel? currentUser;

  Widget dropDown(List<UserModel> values) => DropdownButtonFormField<UserModel>(
        decoration: const InputDecoration(
          label: Text(StringsManager.assignToUser),
        ),
        items: values
            .map((item) => DropdownMenuItem<UserModel>(
                  value: item,
                  child: Text(
                    item.username,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: currentUser,
        onChanged: (value) {
          setState(() {
            currentUser = value;
          });
        },
        isExpanded: true,
      );

  DropdownMenuItem<String> oneItem(String txt) =>
      DropdownMenuItem<String>(child: Text(txt));

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
