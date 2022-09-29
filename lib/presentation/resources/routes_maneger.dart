import 'package:flutter/material.dart';
import 'package:posbank/app/di.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/views/add_user_view.dart';
import 'package:posbank/presentation/views/edit_note/edite_note_view.dart';
import 'package:posbank/presentation/views/note/note.dart';
import 'package:posbank/presentation/views/options_notes_view.dart';
import 'package:posbank/presentation/temp.dart';

class Routes {
  static const String notesHome = "/notesHome";
  static const String editNote = "/editNote";
  static const String addUser = "/addUser";
  static const String optionsNote = "/optionsNote";
  static const String temp = "/temp";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // home
      case Routes.notesHome:
        initAllNotesModule();
        return MaterialPageRoute(builder: (_) => const NotesView());
      // edit
      case Routes.editNote:
        initUpdateNoteModule();
        return MaterialPageRoute(builder: (_) => const EditNoteView());
      // add user
      case Routes.addUser:
        initAddUserModule();
        return MaterialPageRoute(builder: (_) => const AddUserView());
      // options
      case Routes.optionsNote:
        return MaterialPageRoute(builder: (_) => const OptionsNoteView());
      // delete it --> (just for test)
      case Routes.temp:
        return MaterialPageRoute(builder: (_) => const TempView());
      default:
        return _unDefinedRout();
    }
  }

  static Route<dynamic> _unDefinedRout() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(StringsManager.noRouteFound),
              ),
              body: const Center(
                child: Text(StringsManager.noRouteFound),
              ),
            ));
  }
}
