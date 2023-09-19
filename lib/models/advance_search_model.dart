class AdvanceSearchModel {
  AdvanceSearchModel(
      {this.way,
      this.sort,
      this.title,
      this.cast,
      this.score,
      this.genre,
      this.from,
      this.to,
      this.lang,
      this.double,
      this.age});

  String? way, sort, title, cast, score, genre, from, to, lang, age, country,double;

  Map<String, dynamic> toJson() => {
        "way": way,
        "sort": sort,
        "title": title,
        "cast": cast,
        "score": score,
        "genre": genre,
        "from": from,
        "to": to,
        "lang": lang,
        "age": age,
        "country":country,
        "double":double
      };
}
