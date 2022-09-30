class UserResponse {
  String? username;
  String? password;
  String? email;
  String? imageAsBase64;
  String? intrestId;
  String? id;

  UserResponse(
      {this.username,
        this.password,
        this.email,
        this.imageAsBase64,
        this.intrestId,
        this.id});

  UserResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    imageAsBase64 = json['imageAsBase64'];
    intrestId = json['intrestId'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['imageAsBase64'] = this.imageAsBase64;
    data['intrestId'] = this.intrestId;
    data['id'] = this.id;
    return data;
  }
}