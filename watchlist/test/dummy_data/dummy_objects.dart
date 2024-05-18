import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/movie.dart';
import 'package:watchlist/domain/entities/tv.dart';

const testWatchlist = WatchlistTable(
  id: 1,
  title: "test",
  posterPath: "poster.png",
  overview: "overview",
);

const tMovie = Movie(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

const tv = Tv(
  backdropPath: "backdrop.png",
  firstAirDate: "2023-09-09",
  genreIds: [1, 2, 3],
  id: 1,
  name: "Sinetron Azab",
  originalCountry: ["Indonesia"],
  originalLanguage: "Indonesia",
  originalName: "Sinetron Indosiar",
  overview: "Sinetron indosiar terbaik",
  popularity: 4.5,
  posterPath: "poster.png",
  voteAverage: 4.8,
  voteCount: 900,
);

final testMovieMap = {
  'id': 1,
  'overview': 'ok',
  'posterPath': 'poster.png',
  'title': 'test',
};
final testWatchlists = [
  const WatchlistTable(
    id: 1,
    title: "test",
    posterPath: "poster.png",
    overview: "ok",
  )
];

final tMovieList = <Movie>[tMovie];
final tvs = <Tv>[tv];
