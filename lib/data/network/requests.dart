class NoteUpdateRequest {
  String id;
  String text;
  String userId;
  String placeDateTime;

  NoteUpdateRequest(this.id, this.text, this.userId, this.placeDateTime);
}

class NoteInsertRequest {
  String text;
  String userId;
  String placeDateTime;

  NoteInsertRequest(this.text, this.userId, this.placeDateTime);
}

class UserInsertRequest {
  String username;
  String password;
  String email;
  String? imageAsBase64;
  String intrestId;

  UserInsertRequest(this.username, this.password, this.email,
      this.imageAsBase64, this.intrestId);
}
