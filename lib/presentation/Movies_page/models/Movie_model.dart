import 'dart:convert';
/// Search : [{"Title":"Italian Spiderman","Year":"2007","imdbID":"tt2705436","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZWQxMjcwNjItZjI0ZC00ZTc4LWIwMzItM2Q0YTZhNzI3NzdlXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_SX300.jpg"},{"Title":"Superman, Spiderman or Batman","Year":"2011","imdbID":"tt2084949","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMjQ4MzcxNDU3N15BMl5BanBnXkFtZTgwOTE1MzMxNzE@._V1_SX300.jpg"},{"Title":"Spiderman","Year":"1990","imdbID":"tt0100669","Type":"movie","Poster":"N/A"},{"Title":"The Amazing Spiderman 2 Webb Cut","Year":"2021","imdbID":"tt18351128","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYzYzZDViNWYtNWViMS00NDMxLThlN2YtZjFkOWMwODkzNzhiXkEyXkFqcGdeQXVyMTUwMzM4NzU0._V1_SX300.jpg"},{"Title":"Spiderman the Verse","Year":"2019–","imdbID":"tt12122034","Type":"series","Poster":"https://m.media-amazon.com/images/M/MV5BNjA2NmZhOGEtZTQ5OS00MDI0LTg4N2UtYTRmOTllM2I2NDlhXkEyXkFqcGdeQXVyNTU4OTE5Nzc@._V1_SX300.jpg"},{"Title":"Spiderman in Cannes","Year":"2016","imdbID":"tt5978586","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZDlmMGQwYmItNTNmOS00OTNkLTkxNTYtNDM3ZWVlMWUyZDIzXkEyXkFqcGdeQXVyMTA5Mzk5Mw@@._V1_SX300.jpg"},{"Title":"Spiderman","Year":"2010","imdbID":"tt1785572","Type":"movie","Poster":"N/A"},{"Title":"Spiderman and Grandma","Year":"2009","imdbID":"tt1433184","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMjE3Mzg0MjAxMl5BMl5BanBnXkFtZTcwNjIyODg5Mg@@._V1_SX300.jpg"},{"Title":"Fighting, Flying and Driving: The Stunts of Spiderman 3","Year":"2007","imdbID":"tt1132238","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNTI3NDE1ZmEtMTRiMS00YTY4LTk0OGItNjY4YmI0MDM4OGM4XkEyXkFqcGdeQXVyODE2NDgwMzM@._V1_SX300.jpg"},{"Title":"Amazing Spiderman Syndrome","Year":"2012","imdbID":"tt2586634","Type":"movie","Poster":"N/A"}]
/// totalResults : "23"
/// Response : "True"

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));
String movieModelToJson(MovieModel data) => json.encode(data.toJson());
class MovieModel {
  MovieModel({
    List<Search>? search,
    String? totalResults,
    String? response,}){
    _search = search;
    _totalResults = totalResults;
    _response = response;
  }

  MovieModel.fromJson(dynamic json) {
    if (json['Search'] != null) {
      _search = [];
      json['Search'].forEach((v) {
        _search?.add(Search.fromJson(v));
      });
    }
    _totalResults = json['totalResults'];
    _response = json['Response'];
  }
  List<Search>? _search;
  String? _totalResults;
  String? _response;
  MovieModel copyWith({  List<Search>? search,
    String? totalResults,
    String? response,
  }) => MovieModel(  search: search ?? _search,
    totalResults: totalResults ?? _totalResults,
    response: response ?? _response,
  );
  List<Search>? get search => _search;
  String? get totalResults => _totalResults;
  String? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_search != null) {
      map['Search'] = _search?.map((v) => v.toJson()).toList();
    }
    map['totalResults'] = _totalResults;
    map['Response'] = _response;
    return map;
  }

}

/// Title : "Italian Spiderman"
/// Year : "2007"
/// imdbID : "tt2705436"
/// Type : "movie"
/// Poster : "https://m.media-amazon.com/images/M/MV5BZWQxMjcwNjItZjI0ZC00ZTc4LWIwMzItM2Q0YTZhNzI3NzdlXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_SX300.jpg"

Search searchFromJson(String str) => Search.fromJson(json.decode(str));
String searchToJson(Search data) => json.encode(data.toJson());
class Search {
  Search({
    String? title,
    String? year,
    String? imdbID,
    String? type,
    String? poster,}){
    _title = title;
    _year = year;
    _imdbID = imdbID;
    _type = type;
    _poster = poster;
  }

  Search.fromJson(dynamic json) {
    _title = json['Title'];
    _year = json['Year'];
    _imdbID = json['imdbID'];
    _type = json['Type'];
    _poster = json['Poster'];
  }
  String? _title;
  String? _year;
  String? _imdbID;
  String? _type;
  String? _poster;
  Search copyWith({  String? title,
    String? year,
    String? imdbID,
    String? type,
    String? poster,
  }) => Search(  title: title ?? _title,
    year: year ?? _year,
    imdbID: imdbID ?? _imdbID,
    type: type ?? _type,
    poster: poster ?? _poster,
  );
  String? get title => _title;
  String? get year => _year;
  String? get imdbID => _imdbID;
  String? get type => _type;
  String? get poster => _poster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['Year'] = _year;
    map['imdbID'] = _imdbID;
    map['Type'] = _type;
    map['Poster'] = _poster;
    return map;
  }

}