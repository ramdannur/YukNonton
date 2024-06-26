import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/entities/movie.dart';
import 'package:watchlist/domain/entities/tv.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  const WatchlistTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      this.type = "movie"});

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      type: map['type']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type
      };

  Movie toMovieEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Tv toTvEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
