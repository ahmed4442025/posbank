import 'package:flutter/material.dart';

class StringsManager {
  static const String noRouteFound = "no Route fount";

  // app bar
  static const notesAB = "Notes";
  static const editNotesAB = "Edit Notes";
  static const optionsAB = "Options";
  static const addUserAB = "Add User";

  // add user
  static const userName = "User Name";
  static const password = "Password";
  static const email = "Email";
  static const interest = "Interest";
  static const passwordError =
      "password should have alphabet and numbers with minimum length of 8 chars";
  static const emailError = "Interest";
  static const save = "Save";

  // edit notes
  static const note = "Note";
  static const assignToUser = "Assign To User";

  // options
  static const useLocal = "Use Local DataBase";
  static const useLocalDis =
      "instead of using HTTP call to work with the app data, Please use SQLite for this";

  // error handler
  static const String success = "success";
  static const String badRequestError = "bad_request_error";
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal_server_error";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "default_error";
  static const String cacheError = "cache_error";
  static const String noInternetError = "no_internet_error";
}
