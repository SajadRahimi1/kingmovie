class TicketModel {
  String? status;
  String? forceOut;
  User? user;
  String? error;
  String? message;
  Data? data;
  String? homeAddress;
  String? buy;
  String? buyText;

  TicketModel(
      {this.status,
      this.forceOut,
      this.user,
      this.error,
      this.message,
      this.data,
      this.homeAddress,
      this.buy,
      this.buyText});

  TicketModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? title;
  String? active;

  ListData({this.code, this.title, this.active});

  ListData.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    active = json["active"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["title"] = title;
    data["active"] = active;
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
