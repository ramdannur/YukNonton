import 'package:core/common/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

const testTv = Tv(
    backdropPath: "backdrop.png",
    firstAirDate: "2023-09-09",
    id: 1,
    name: "Tv",
    originalLanguage: "Indonesia",
    originalName: "Tv",
    overview: "Overview",
    popularity: 8.9,
    posterPath: "poster.png",
    voteAverage: 4.6,
    voteCount: 900,
    genreIds: [1, 2, 3],
    originalCountry: ["indonesia"]);

const testTvDetail = TvDetail(
    adult: false,
    backdropPath: "backdrop.png",
    episodeRunTime: [60, 120],
    firstAirDate: "2023-09-09",
    genres: [
      Genre(id: 1, name: "genre"),
      Genre(id: 2, name: "genre 2"),
    ],
    homepage: "/home-page",
    id: 1,
    inProduction: false,
    languages: ["Indonesia"],
    lastAirDate: "2023-09-09",
    name: "Tv",
    numberOfEpisodes: 20,
    numberOfSeasons: 5,
    originCountry: ["Indonesia"],
    originalLanguage: "Indonesia",
    originalName: "Tv",
    overview: "Overview",
    popularity: 8.9,
    posterPath: "poster.png",
    status: "started",
    tagline: "tagline",
    type: "type",
    voteAverage: 4.6,
    voteCount: 900,
    seasons: [
      SeasonEntity(id: 1, name: "Season 1", episodeCount: 1),
    ]);

const testTvTable = WatchlistTable(
  id: 1,
  title: 'Tv',
  posterPath: 'poster.png',
  overview: 'Overview',
);

const testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
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

final testTvList = [testTv];
final tvs = <Tv>[tv];
