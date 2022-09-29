import 'package:flutter/material.dart';
import 'routes_maneger.dart';

class ViewsManager {
  // =============== const pages =================
  // ------------ with out back ------------

  // home
  static void openNotesView(context) {
    _openViewNoBack(context, Routes.notesHome);
  }

  // temp
  static void openTemp(context) {
    _openViewNoBack(context, Routes.temp);
  }

  // ------------ with back ------------
  // NOTE : "WB" (with back) in the end of function name that mean you can use back button

  // add user
  static void openAddUserWB(context) {
    _openViewWithBack(context, Routes.addUser);
  }

  // forget password
  static void openEditNoteWB(context) {
    _openViewWithBack(context, Routes.editNote);
  }

  // options
  static void openOptionsWB(context) {
    _openViewWithBack(context, Routes.optionsNote);
  }

  // go back if you can
  static void backIfUCan(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // ========== privet methods ==========

  // user can't back to last page
  static void _openViewNoBack(context, nextPage) {
    Navigator.of(context).pushNamedAndRemoveUntil(nextPage, (route) => false);
  }

  // user can back to last page
  static void _openViewWithBack(context, nextPage) {
    Navigator.of(context).pushNamed(nextPage);
  }
}
