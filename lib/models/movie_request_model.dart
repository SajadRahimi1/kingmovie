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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["reply"] = reply;
    if (replyArray != null) {
      data["replyArray"] = replyArray?.toJson();
    }
    data["active"] = active;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["text"] = text;
    data["code"] = code;
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
