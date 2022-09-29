class NoteUpdateUCInput {
  String id;
  String text;
  String userId;
  String placeDateTime;

  NoteUpdateUCInput(this.id, this.text, this.userId, this.placeDateTime);
}

class NoteInsertUCInput {
  String text;
  String userId;
  String placeDateTime;

  NoteInsertUCInput(this.text, this.userId, this.placeDateTime);
}

class UserInsertUCInput {
  String username;
  String password;
  String email;
  String? imageAsBase64;
  String intrestId;

  UserInsertUCInput(this.username, this.password, this.email,
      this.imageAsBase64, this.intrestId);
}
