class Movie {
   String _backdropPath;
   int _id;
   String _title;
   String _original_title;
   String _overview;
   String _posterPath;
   String _mediaType;
   bool _adult;
   String _originalLanguage;
   List<int> _genreIds;
   double _popularity;
   String _release_date;
   bool  _video;
   double _voteAverage;
   int _voteCount;


  // Constructor
  Movie(
     this._backdropPath,
     this._id,
     this._title,
     this._original_title,
     this._overview,
     this._posterPath,
     this._mediaType,
     this._adult,
     this._originalLanguage,
     this._genreIds,
     this._popularity,
     this._release_date,
     this._video,
     this._voteAverage,
     this._voteCount,

  );


   String get original_title => _original_title;

  set original_title(String value) {
    _original_title = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get voteCount => _voteCount;

  set voteCount(int value) {
    _voteCount = value;
  }

  double get voteAverage => _voteAverage;

  set voteAverage(double value) {
    _voteAverage = value;
  }





  List<int> get genreIds => _genreIds;

  set genreIds(List<int> value) {
    _genreIds = value;
  }

  String get originalLanguage => _originalLanguage;

  set originalLanguage(String value) {
    _originalLanguage = value;
  }

  bool get adult => _adult;

  set adult(bool value) {
    _adult = value;
  }

  String get mediaType => _mediaType;

  set mediaType(String value) {
    _mediaType = value;
  }

  String get posterPath => _posterPath;

  set posterPath(String value) {
    _posterPath = value;
  }

  String get overview => _overview;

  set overview(String value) {
    _overview = value;
  }


   String get release_date => _release_date;

  set release_date(String value) {
    _release_date = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get backdropPath => _backdropPath;

  set backdropPath(String value) {
    _backdropPath = value;
  }

   bool get video => _video;

  set video(bool value) {
    _video = value;
  }


}