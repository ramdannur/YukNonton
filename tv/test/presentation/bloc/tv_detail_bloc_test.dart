import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_recommendation_tvs.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetRecommendationTvs, GetWatchlistStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetMovieDetail;
  late MockGetRecommendationTvs mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetTvDetail();
    mockGetMovieRecommendations = MockGetRecommendationTvs();
    tvDetailBloc = TvDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations);
  });

  const tId = 1;

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
      voteCount: 900);
  final tvs = <Tv>[tv];

  group('Get Tv Detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvDetailEmpty());
    });

    blocTest<TvDetailBloc, TvDetailState>('Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(tvs));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [TvDetailLoading(), TvDetailHasData(testTvDetail, tvs)],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>('Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Left(ServerFailure("server error")));
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(tvs));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [TvDetailLoading(), const TvDetailError("server error")],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>('Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => const Left(ServerFailure("server error")));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [TvDetailLoading(), const TvDetailError("server error")],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });
}
