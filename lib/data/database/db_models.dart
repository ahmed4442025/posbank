import 'package:posbank/data/database/db_strings_manager.dart';

class NoteUpdateDB {
  String id;
  String text;
  String userId;
  String placeDateTime;

  NoteUpdateDB(this.id, this.text, this.userId, this.placeDateTime);

  String toUpdate() {
    return 'UPDATE ${DBStringsManager.notesTable} '
        'set ${DBStringsManager.notesText} = ?'
        'set ${DBStringsManager.notesPlaceDateTime} = ?'
        'set ${DBStringsManager.notesUserId} = ?'
        'WHERE ${DBStringsManager.notesId} = ?';
  }

  List<dynamic> toValues() => [text, placeDateTime, userId, id];
}

class NoteInsertDB {
  String text;
  String userId;
  String placeDateTime;

  NoteInsertDB(this.text, this.userId, this.placeDateTime);

  String toInsert() {
    String names = '${DBStringsManager.notesText},'
        ' ${DBStringsManager.notesPlaceDateTime},'
        ' ${DBStringsManager.notesUserId}';
    String values = '"$text", "$placeDateTime", "$userId" ';
    return 'INSERT INTO ${DBStringsManager.notesTable}($names) VALUES($values)';
  }
}

class UserInsertDB {
  String username;
  String password;
  String email;
  String? imageAsBase64;
  String intrestId;

  UserInsertDB(this.username, this.password, this.email, this.imageAsBase64,
      this.intrestId);

  String toInsert() {
    String names = '${DBStringsManager.usersUsername},'
        ' ${DBStringsManager.usersPassword},'
        ' ${DBStringsManager.usersEmail},'
        ' ${DBStringsManager.usersImageAsBase64},'
        ' ${DBStringsManager.usersIntrestId}';
    String values =
        '"$username", "$password", "$email", "$imageAsBase64", "$intrestId" ';
    return 'INSERT INTO ${DBStringsManager.usersTable}($names) VALUES($values)';
  }
}

class InterestedInsertDB {
  String text;

  InterestedInsertDB(this.text);

  String toInsert() {
    String names = DBStringsManager.interestedText;
    String values = '"$text"';
    return 'INSERT INTO ${DBStringsManager.interestedTable}($names) VALUES($values)';
  }
}
