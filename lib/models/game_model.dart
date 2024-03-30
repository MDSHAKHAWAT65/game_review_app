class GameModel {
  int? id;
  String? title;
  String? imgUrl;
  String? avg;
  List<Ratings>? ratings;

  GameModel({this.id, this.title, this.imgUrl, this.avg, this.ratings});

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['img_url'];
    avg = json['avg'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img_url'] = imgUrl;
    data['avg'] = avg;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  User? user;
  int? rating;
  String? comment;
  String? coordinate;

  Ratings({this.user, this.rating, this.comment, this.coordinate});

  Ratings.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    coordinate = json['coordinate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['coordinate'] = coordinate;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;

  User({this.id, this.name, this.username, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
