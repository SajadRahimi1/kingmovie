import 'package:king_movie/models/movie_widget_model.dart';

class HomeModel {
  String? status;
  String? forceOut;
  String? error;
  String? message;
  User? user;
  Data? data;
  List<Best>? best;
  List<Award>? award;
  List<Pack>? pack;
  List<String>? sort;
  List<String>? double;
  List<String>? lang;
  List<String>? country;
  List<String>? score;
  List<String>? way;
  List<String>? age;
  List<String>? genre;
  List<int>? years;
  String? homeAddress;
  String? buy;
  String? buyText;

  HomeModel(
      {this.status,
      this.forceOut,
      this.error,
      this.user,
      this.message,
      this.data,
      this.best,
      this.award,
      this.pack,
      this.sort,
      this.double,
      this.lang,
      this.country,
      this.score,
      this.way,
      this.age,
      this.genre,
      this.years,
      this.homeAddress,
      this.buy,
      this.buyText});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    forceOut = json["forceOut"];
    error = json["error"];
    message = json["message"];
    user = json['user'].length > 0 ? User.fromJson(json['user']) : null;
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    best = json["best"] == null
        ? null
        : (json["best"] as List).map((e) => Best.fromJson(e)).toList();
    award = json["award"] == null
        ? null
        : (json["award"] as List).map((e) => Award.fromJson(e)).toList();
    pack = json["pack"] == null
        ? null
        : (json["pack"] as List).map((e) => Pack.fromJson(e)).toList();
    sort = json["sort"] == null ? null : List<String>.from(json["sort"]);
    double = json["double"] == null ? null : List<String>.from(json["double"]);
    lang = json["lang"] == null ? null : List<String>.from(json["lang"]);
    country =
        json["country"] == null ? null : List<String>.from(json["country"]);
    score = json["score"] == null ? null : List<String>.from(json["score"]);
    way = json["way"] == null ? null : List<String>.from(json["way"]);
    age = json["age"] == null ? null : List<String>.from(json["age"]);
    genre = json["genre"] == null ? null : List<String>.from(json["genre"]);
    years = json["years"] == null ? null : List<int>.from(json["years"]);
    homeAddress = json["homeAddress"];
    buy = json["buy"];
    buyText = json["buyText"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["forceOut"] = forceOut;

    data["error"] = error;
    data["message"] = message;

    if (best != null) {
      data["best"] = best?.map((e) => e.toJson()).toList();
    }
    if (award != null) {
      data["award"] = award?.map((e) => e.toJson()).toList();
    }
    if (pack != null) {
      data["pack"] = pack?.map((e) => e.toJson()).toList();
    }
    if (sort != null) {
      data["sort"] = sort;
    }
    if (double != null) {
      data["double"] = double;
    }
    if (lang != null) {
      data["lang"] = lang;
    }
    if (country != null) {
      data["country"] = country;
    }
    if (score != null) {
      data["score"] = score;
    }
    if (way != null) {
      data["way"] = way;
    }
    if (age != null) {
      data["age"] = age;
    }
    if (genre != null) {
      data["genre"] = genre;
    }
    if (years != null) {
      data["years"] = years;
    }
    data["homeAddress"] = homeAddress;
    data["buy"] = buy;
    data["buyText"] = buyText;
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
  List<Box>? box;
  List<Slider>? slider;
  List<Series>? series;
  List<SeriesDouble>? seriesDouble;
  List<Movie>? movie;
  List<MovieDouble>? movieDouble;
  List<Suggest>? suggest;

  Data(
      {this.box,
      this.slider,
      this.series,
      this.seriesDouble,
      this.movie,
      this.movieDouble,
      this.suggest});

  Data.fromJson(Map<String, dynamic> json) {
    box = json["box"] == null
        ? null
        : (json["box"] as List).map((e) => Box.fromJson(e)).toList();
    slider = json["slider"] == null
        ? null
        : (json["slider"] as List).map((e) => Slider.fromJson(e)).toList();
    series = json["series"] == null
        ? null
        : (json["series"] as List).map((e) => Series.fromJson(e)).toList();
    seriesDouble = json["seriesDouble"] == null
        ? null
        : (json["seriesDouble"] as List)
            .map((e) => SeriesDouble.fromJson(e))
            .toList();
    movie = json["movie"] == null
        ? null
        : (json["movie"] as List).map((e) => Movie.fromJson(e)).toList();
    movieDouble = json["movieDouble"] == null
        ? null
        : (json["movieDouble"] as List)
            .map((e) => MovieDouble.fromJson(e))
            .toList();
    suggest = json["suggest"] == null
        ? null
        : (json["suggest"] as List).map((e) => Suggest.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (box != null) {
      data["box"] = box?.map((e) => e.toJson()).toList();
    }
    if (slider != null) {
      data["slider"] = slider?.map((e) => e.toJson()).toList();
    }
    if (series != null) {
      data["series"] = series?.map((e) => e.toJson()).toList();
    }
    if (seriesDouble != null) {
      data["seriesDouble"] = seriesDouble?.map((e) => e.toJson()).toList();
    }
    if (movie != null) {
      data["movie"] = movie?.map((e) => e.toJson()).toList();
    }
    if (movieDouble != null) {
      data["movieDouble"] = movieDouble?.map((e) => e.toJson()).toList();
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
  bool? double;
  String? poster;
  String? genre;
  Action5? action;

  Suggest(
      {this.id,
      this.title,
      this.year,
      this.double,
      this.poster,
      this.genre,
      this.action});

  Suggest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    double = json["double"];
    poster = json["poster"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action5.fromJson(json["action"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["double"] = double;
    data["poster"] = poster;
    data["genre"] = genre;
    if (action != null) {
      data["action"] = action?.toJson();
    }
    return data;
  }
}

class Action5 {
  String? type;
  String? value;

  Action5({this.type, this.value});

  Action5.fromJson(Map<String, dynamic> json) {
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

class MovieDouble {
  String? id;
  String? title;
  String? year;
  bool? double;
  String? poster;
  String? genre;
  Action4? action;

  MovieDouble(
      {this.id,
      this.title,
      this.year,
      this.double,
      this.poster,
      this.genre,
      this.action});

  MovieDouble.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    double = json["double"];
    poster = json["poster"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action4.fromJson(json["action"]);
  }
MovieWidgetModel toWidgetModel()=>MovieWidgetModel(
    genre: genre,
    double: double,
    id: id,
    poster: poster,
    title: title,
    year: year
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["double"] = double;
    data["poster"] = poster;
    data["genre"] = genre;
    if (action != null) {
      data["action"] = action?.toJson();
    }
    return data;
  }
}

class Action4 {
  String? type;
  String? value;

  Action4({this.type, this.value});

  Action4.fromJson(Map<String, dynamic> json) {
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

class Movie {
  String? id;
  String? title;
  String? year;
  bool? double;
  String? poster;
  String? genre;
  Action3? action;

  Movie(
      {this.id,
      this.title,
      this.year,
      this.double,
      this.poster,
      this.genre,
      this.action});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    double = json["double"];
    poster = json["poster"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action3.fromJson(json["action"]);

  
  }

  MovieWidgetModel toWidgetModel()=>MovieWidgetModel(
    double: double,
    id: id,
    genre: genre,
    poster: poster,
    title: title,
    year: year
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["double"] = double;
    data["poster"] = poster;
    data["genre"] = genre;
    if (action != null) {
      data["action"] = action?.toJson();
    }
    return data;
  }
}

class Action3 {
  String? type;
  String? value;

  Action3({this.type, this.value});

  Action3.fromJson(Map<String, dynamic> json) {
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

class SeriesDouble {
  String? id;
  String? title;
  String? year;
  String? poster;
  bool? double;
  String? genre;
  Action2? action;

  SeriesDouble(
      {this.id,
      this.title,
      this.year,
      this.poster,
      this.double,
      this.genre,
      this.action});

  SeriesDouble.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    poster = json["poster"];
    double = json["double"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action2.fromJson(json["action"]);
  }MovieWidgetModel toWidgetModel()=>MovieWidgetModel(
    double: double,
    id: id,
    genre: genre,
    poster: poster,
    title: title,
    year: year
  );

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

class Action2 {
  String? type;
  String? value;

  Action2({this.type, this.value});

  Action2.fromJson(Map<String, dynamic> json) {
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

class Series {
  String? id;
  String? title;
  String? year;
  bool? double;
  String? poster;
  String? genre;
  Action1? action;

  Series(
      {this.id,
      this.title,
      this.year,
      this.double,
      this.poster,
      this.genre,
      this.action});

  Series.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    double = json["double"];
    poster = json["poster"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action1.fromJson(json["action"]);
  }MovieWidgetModel toWidgetModel()=>MovieWidgetModel(
    double: double,
    id: id,
    poster: poster,
    genre: genre,
    title: title,
    year: year
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["double"] = double;
    data["poster"] = poster;
    data["genre"] = genre;
    if (action != null) {
      data["action"] = action?.toJson();
    }
    return data;
  }
}

class Action1 {
  String? type;
  String? value;

  Action1({this.type, this.value});

  Action1.fromJson(Map<String, dynamic> json) {
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

class Slider {
  String? id;
  String? title;
  String? year;
  bool? double;
  String? poster;
  String? vote;
  String? voter;
  String? genre;
  Action? action;

  Slider(
      {this.id,
      this.title,
      this.year,
      this.double,
      this.poster,
      this.vote,
      this.voter,
      this.genre,
      this.action});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    year = json["year"];
    double = json["double"];
    poster = json["poster"];
    vote = json["vote"];
    voter = json["voter"];
    genre = json["genre"];
    action = json["action"] == null ? null : Action.fromJson(json["action"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["year"] = year;
    data["double"] = double;
    data["poster"] = poster;
    data["vote"] = vote;
    data["voter"] = voter;
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

class Box {
  String? code;
  int? number;
  String? id;
  String? poster;

  Box({this.code, this.number, this.id, this.poster});

  Box.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    number = json["number"];
    id = json["id"];
    poster = json["poster"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["number"] = number;
    data["id"] = id;
    data["poster"] = poster;
    return data;
  }
}
