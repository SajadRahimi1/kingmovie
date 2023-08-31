class FavoriteModel {
  String? status;
  String? forceOut;
  User? user;
  String? error;
  String? message;
  Data? data;
  String? homeAddress;
  String? buy;
  String? buyText;

  FavoriteModel(
      {this.status,
      this.forceOut,
      this.user,
      this.error,
      this.message,
      this.data,
      this.homeAddress,
      this.buy,
      this.buyText});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    error = json["error"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);

    homeAddress = json["homeAddress"];
    buy = json["buy"];
    buyText = json["buyText"];
  }
}

class Data {
  List<ListData>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null
        ? null
        : List<ListData>.from(json['list'].map((x) => ListData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data["list"] = list?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  String? id;
  String? title;
  String? year;
  String? poster;

  ListData({this.id, this.title, this.year, this.poster});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    poster = json["poster"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["poster"] = poster;
    return data;
  }
}

class User {
  String? email;
  String? name;
  String? vipDate;
  String? mobile;
  String? vip;

  User({this.email, this.name, this.vipDate, this.mobile, this.vip});

  User.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    vipDate = json["vipDate"];
    mobile = json["mobile"];
    vip = json["vip"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["name"] = name;
    data["vipDate"] = vipDate;
    data["mobile"] = mobile;
    data["vip"] = vip;
    return data;
  }
}
