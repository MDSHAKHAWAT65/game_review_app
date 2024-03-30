class UserModel {
  int? id;
  String? name;
  String? username;
  String? type;
  String? email;

  UserModel({this.id, this.name, this.username, this.type, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    type = json['type'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['type'] = this.type;
    data['email'] = this.email;
    return data;
  }
}
