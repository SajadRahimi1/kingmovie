
class SearchModel {
  String? status;
  String? forceOut;
  List<dynamic>? user;
  String? error;
  String? message;
  Data? data;

  SearchModel({this.status, this.forceOut, this.user, this.error, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];
    user = json["user"] ?? [];
    error = json["error"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["forceOut"] = forceOut;
    if(user != null) {
      _data["user"] = user;
    }
    _data["error"] = error;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  List<DataList>? dataList;

  Data({this.dataList});

  Data.fromJson(Map<String, dynamic> json) {
    dataList = json["list"] == null ? null : (json["list"] as List).map((e) => DataList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(dataList != null) {
      _data["dataList"] = dataList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DataList {
  String? id;
  String? title;
  String? year;
  String? poster;
  String? vote;
  String? lang;
  bool? double;
  String? subtitle;
  int? like;
  String? age;
  String? time;
  String? story;
  String? genre;

  DataList({this.id, this.title, this.year, this.poster, this.vote, this.lang, this.double, this.subtitle, this.like, this.age, this.time, this.story, this.genre});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    poster = json["poster"];
    vote = json["vote"];
    lang = json["lang"];
    double = json["double"];
    subtitle = json["subtitle"];
    like = json["like"];
    age = json["age"];
    time = json["time"];
    story = json["story"];
    genre = json["genre"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["year"] = year;
    _data["poster"] = poster;
    _data["vote"] = vote;
    _data["lang"] = lang;
    _data["double"] = double;
    _data["subtitle"] = subtitle;
    _data["like"] = like;
    _data["age"] = age;
    _data["time"] = time;
    _data["story"] = story;
    _data["genre"] = genre;
    return _data;
  }
}