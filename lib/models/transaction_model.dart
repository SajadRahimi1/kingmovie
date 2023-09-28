class TransactionModel {
  String? status;
  String? forceOut;
  User? user;
  String? error;
  String? message;
  Data? data;
  String? homeAddress;
  String? buy;
  String? buyText;

  TransactionModel(
      {this.status,
      this.forceOut,
      this.user,
      this.error,
      this.message,
      this.data,
      this.homeAddress,
      this.buy,
      this.buyText});

  TransactionModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["forceOut"] = forceOut;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    data["error"] = error;
    data["message"] = message;
   

    data["homeAddress"] = homeAddress;
    data["buy"] = buy;
    data["buyText"] = buyText;
    return data;
  }
}

class Pack {
  int? id;
  String? title;

  Pack({this.id, this.title});

  Pack.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    return data;
  }
}

class Award {
  String? slug;
  String? title;

  Award({this.slug, this.title});

  Award.fromJson(Map<String, dynamic> json) {
    slug = json["slug"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["slug"] = slug;
    data["title"] = title;
    return data;
  }
}

class Best {
  String? id;
  String? title;

  Best({this.id, this.title});

  Best.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    return data;
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
}

class ListData {
  String? title;
  String? date;

  ListData({this.title, this.date});

  ListData.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["date"] = date;
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
