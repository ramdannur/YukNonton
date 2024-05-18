import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final String? originalName;
  final List<String>? originalCountry;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  const Tv({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalName,
    required this.originalCountry,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  const Tv.watchlist({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.originalName,
    this.originalCountry,
    this.originalLanguage,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originalName,
        originalCountry,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
