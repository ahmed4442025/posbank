import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/utilm/utilm.dart';
import 'package:posbank/presentation/views/edit_note/edit_not_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
                      print("saved ");
                      // todo
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
              dropDown(items)
            ],
          ),
        ));
  }

  List<String> items = ["1", "2", "3"];
  String? currentItem;

  Widget dropDown(List<String> values) => DropdownButtonFormField<String>(
    decoration: const InputDecoration(
      label: Text(StringsManager.assignToUser),
    ),
    items: items
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
        .toList(),
    value: currentItem,
    onChanged: (value) {
      setState(() {
        currentItem = value ;
      });
    },
    isExpanded: true,
    hint: const Text("ff"),
  );

  DropdownMenuItem<String> oneItem(String txt) =>
      DropdownMenuItem<String>(child: Text(txt));

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
