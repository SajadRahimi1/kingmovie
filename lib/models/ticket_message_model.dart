class TicketMessageModel {
  String? status;
  String? forceOut;
  User? user;
  String? error;
  String? message;
  Data? data;

  TicketMessageModel({
    this.status,
    this.forceOut,
    this.user,
    this.error,
    this.message,
  });

  TicketMessageModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    error = json["error"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
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
  String? sender;
  String? text;
  String? date;

  ListData({this.sender, this.text, this.date});

  ListData.fromJson(Map<String, dynamic> json) {
    sender = json["sender"];
    text = json["text"];
    date = json["date"];
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
