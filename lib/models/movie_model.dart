class MovieModel {
  String? status;
  String? forceOut;
  String? error;
  String? message;
  Data? data;

  MovieModel({
    this.status,
    this.forceOut,
    this.error,
    this.message,
    this.data,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];

    error = json["error"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }
}

class Data {
  String? id;
  String? title;
  bool? double;
  String? reason;
  String? text;
  String? way;
  String? year;
  String? poster;
  String? vote;
  String? voter;
  String? lang;
  String? meta;
  String? watch;
  int? like;
  String? writer;
  String? director;
  List<WriterArray>? writerArray;
  List<DirectorArray>? directorArray;
  List<GenreArray>? genreArray;
  String? country;
  String? age;
  String? time;
  Link? link;
  String? story;
  String? genre;
  List<Cast>? cast;
  List<Trailer>? trailer;
  List<Comment>? comment;
  List<Suggest>? suggest;

  Data(
      {this.id,
      this.title,
      this.double,
      this.reason,
      this.text,
      this.way,
      this.year,
      this.poster,
      this.vote,
      this.voter,
      this.lang,
      this.meta,
      this.watch,
      this.like,
      this.writer,
      this.director,
      this.writerArray,
      this.directorArray,
      this.genreArray,
      this.country,
      this.age,
      this.time,
      this.link,
      this.story,
      this.genre,
      this.cast,
      this.trailer,
      this.comment,
      this.suggest});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    double = json["double"];
    reason = json["reason"];
    text = json["text"];
    way = json["way"];
    year = json["year"];
    poster = json["poster"];
    vote = json["vote"];
    voter = json["voter"];
    lang = json["lang"];
    meta = json["meta"];
    watch = json["watch"];
    like = json["like"];
    writer = json["writer"];
    director = json["director"];
    writerArray = json["writerArray"] == null
        ? null
        : List<WriterArray>.from(
            json['writerArray'].map((x) => WriterArray.fromJson(x)));
    directorArray = json["directorArray"] == null
        ? null
        : List<DirectorArray>.from(
            json['directorArray'].map((x) => DirectorArray.fromJson(x)));
    genreArray = json["genreArray"] == null
        ? null
        : List<GenreArray>.from(
            json['genreArray'].map((x) => GenreArray.fromJson(x)));
    country = json["country"];
    age = json["age"];
    time = json["time"];
    link = json["link"] == null ? null : Link.fromJson(json["link"]);
    story = json["story"];
    genre = json["genre"];
    cast = json["cast"] == null
        ? null
        : List<Cast>.from(json['cast'].map((x) => Cast.fromJson(x)));
    trailer = json["trailer"] == null
        ? null
        : List<Trailer>.from(json['trailer'].map((x) => Trailer.fromJson(x)));
    comment = json["comment"] == null
        ? null
        : List<Comment>.from(json['comment'].map((x) => Comment.fromJson(x)));
    suggest = json["suggest"] == null
        ? null
        : (json["suggest"] as List).map((e) => Suggest.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["double"] = double;
    data["reason"] = reason;
    data["text"] = text;
    data["way"] = way;
    data["year"] = year;
    data["poster"] = poster;
    data["vote"] = vote;
    data["voter"] = voter;
    data["lang"] = lang;
    data["meta"] = meta;
    data["watch"] = watch;
    data["like"] = like;
    data["writer"] = writer;
    data["director"] = director;
    if (writerArray != null) {
      data["writerArray"] = writerArray?.map((e) => e.toJson()).toList();
    }
    if (directorArray != null) {
      data["directorArray"] = directorArray?.map((e) => e.toJson()).toList();
    }
    if (genreArray != null) {
      data["genreArray"] = genreArray?.map((e) => e.toJson()).toList();
    }
    data["country"] = country;
    data["age"] = age;
    data["time"] = time;

    data["story"] = story;
    data["genre"] = genre;
    if (cast != null) {
      data["cast"] = cast?.map((e) => e.toJson()).toList();
    }
    if (trailer != null) {
      data["trailer"] = trailer?.map((e) => e.toJson()).toList();
    }
    if (comment != null) {
      data["comment"] = comment?.map((e) => e.toJson()).toList();
    }
    if (suggest != null) {
      data["suggest"] = suggest?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Suggest {
  String? id;
  String? title;
  String? year;
  String? poster;
  bool? double;
  String? genre;
  Action? action;

  Suggest(
      {this.id,
      this.title,
      this.year,
      this.poster,
      this.double,
      this.genre,
      this.action});

  Suggest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    poster = json["poster"];
    double = json["double"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action.fromJson(json["action"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["poster"] = poster;
    data["double"] = double;
    data["genre"] = genre;
    if (action != null) {
      data["action"] = action?.toJson();
    }
    return data;
  }
}

class Action {
  String? type;
  String? value;

  Action({this.type, this.value});

  Action.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["value"] = value;
    return data;
  }
}

class Comment {
  String? id;
  String? avatar;
  String? name;
  String? text;
  String? date;
  int? like;
  int? dislike;
  List<Comment>? reply;

  Comment(
      {this.id,
      this.avatar,
      this.name,
      this.text,
      this.date,
      this.like,
      this.dislike,
      this.reply});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    avatar = json["avatar"];
    name = json["name"];
    text = json["text"];
    date = json["date"];
    like = json["like"];
    dislike = json["dislike"];
    reply = json["reply"] == null
        ? null
        : List<Comment>.from(json['reply'].map((x) => Comment.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["avatar"] = avatar;
    data["name"] = name;
    data["text"] = text;
    data["date"] = date;
    data["like"] = like;
    data["dislike"] = dislike;
    if (reply != null) {
      data["reply"] = reply;
    }
    return data;
  }
}

class Trailer {
  String? type;
  String? image;
  String? view;

  Trailer({this.type, this.image, this.view});

  Trailer.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    image = json["image"];
    view = json["view"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["image"] = image;
    data["view"] = view;
    return data;
  }
}

class Cast {
  String? code;
  String? name;
  String? simple;
  String? image;

  Cast({this.code, this.name, this.simple, this.image});

  Cast.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
    simple = json["simple"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["name"] = name;
    data["simple"] = simple;
    data["image"] = image;
    return data;
  }
}

class Link {
  String? allow;
  List<Data1>? data;

  Link({this.allow, this.data});

  Link.fromJson(Map<String, dynamic> json) {
    allow = json["allow"];
    data = json["data"] == null
        ? null
        : List<Data1>.from(json['data'].map((x) => Data1.fromJson(x)));
  }
}

class Data1 {
  String? title;
  String? des;
  List<DownloadList>? list;
  String? color;

  Data1({this.title, this.des, this.list, this.color});

  Data1.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    des = json["des"];
    list = json["list"] == null
        ? null
        : List<DownloadList>.from(
            json['list'].map((x) => DownloadList.fromJson(x)));
    color = json["color"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["des"] = des;
    if (list != null) {
      data["list"] = list?.map((e) => e.toJson()).toList();
    }
    data["color"] = color;
    return data;
  }
}

class DownloadList {
  String? link;
  String? format;
  String? title;
  String? id;
  List<DownloadList>? list;

  DownloadList({this.link, this.format, this.title, this.id, this.list});

  DownloadList.fromJson(Map<String, dynamic> json) {
    link = json["link"];
    format = json["format"];
    title = json["title"];
    id = json['id'];
    list = json["list"] == null
        ? null
        : List<DownloadList>.from(
            json['list'].map((x) => DownloadList.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["link"] = link;
    data["format"] = format;
    data["title"] = title;
    return data;
  }
}

class GenreArray {
  String? id;
  String? title;

  GenreArray({this.id, this.title});

  GenreArray.fromJson(Map<String, dynamic> json) {
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

class DirectorArray {
  String? code;
  String? name;

  DirectorArray({this.code, this.name});

  DirectorArray.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["name"] = name;
    return data;
  }
}

class WriterArray {
  String? code;
  String? name;

  WriterArray({this.code, this.name});

  WriterArray.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["name"] = name;
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
