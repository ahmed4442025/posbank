class InterestResponse {
  String? intrestText;
  String? id;

  InterestResponse({this.intrestText, this.id});

  InterestResponse.fromJson(Map<String, dynamic> json) {
    intrestText = json['intrestText'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intrestText'] = this.intrestText;
    data['id'] = this.id;
    return data;
  }
}