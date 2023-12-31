class TableModel {
  String? status;
  String? error;
  String? message;
  List<Week>? week;
  Data? data;

  TableModel(
      {this.status,
      this.error,
      this.message,
      this.week,
      this.data,
});

  TableModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    error = json["error"];
    message = json["message"];
    week = json["week"] == null
        ? null
        : (json["week"] as List).map((e) => Week.fromJson(e)).toList();
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

 }

class Data {
  List<ListData>? listData;

  Data({this.listData});

  Data.fromJson(Map<String, dynamic> json) {
    listData = json["list"] == null
        ? null
        : List<ListData>.from(json['list'].map((x) => ListData.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listData != null) {
      data["list"] = listData?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  String? id;
  String? title;
  String? time;
  String? poster;
  String? season;

  ListData({this.id, this.title, this.time, this.poster, this.season});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    time = json["time"];
    poster = json["poster"];
    season = json["season"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["time"] = time;
    data["poster"] = poster;
    data["season"] = season;
    return data;
  }
}

class Week {
  String? id;
  String? title;
  String? selected;

  Week({this.id, this.title, this.selected});

  Week.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    selected = json["selected"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["selected"] = selected;
    return data;
  }
}
