class RequestMovieModel {
  String? status;
  String? forceOut;
  String? error;
  String? message;
  Data? data;

  RequestMovieModel({
    this.status,
    this.forceOut,
  });

  RequestMovieModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];
    

    error = json["error"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["forceOut"] = forceOut;

    _data["error"] = error;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }

    return _data;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (list != null) {
      _data["list"] = list?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListData {
  String? title;
  String? reply;
  ReplyArray? replyArray;
  String? active;

  ListData({this.title, this.reply, this.replyArray, this.active});

  ListData.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    reply = json["reply"];
    replyArray = json["replyArray"] == null
        ? null
        : ReplyArray.fromJson(json["replyArray"]);
    active = json["active"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["reply"] = reply;
    if (replyArray != null) {
      _data["replyArray"] = replyArray?.toJson();
    }
    _data["active"] = active;
    return _data;
  }
}

class ReplyArray {
  String? text;
  String? code;

  ReplyArray({this.text, this.code});

  ReplyArray.fromJson(Map<String, dynamic> json) {
    text = json["text"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["text"] = text;
    _data["code"] = code;
    return _data;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["name"] = name;
    _data["vipDate"] = vipDate;
    _data["mobile"] = mobile;
    _data["vip"] = vip;
    return _data;
  }
}
