import 'dart:convert';

import 'package:core/common/data/datasources/remote/config.dart';
import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/remote/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = theMovieDbApiKey;
  const baseUrl = theMovieDbBaseUrl;

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv Series', () {
    final tMovieList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_list_response.json'))).results;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_list_response.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tMovieList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_list_response.json'))).results;

    test('should return list of tv series when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_list_response.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tMovieList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_list_response.json'))).results;

    test('should return list of tv series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_list_response.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    const tId = 1;
    final tMovieDetail = TvDetailResponse.fromJson(json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tMovieList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_list_response.json'))).results;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_list_response.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_list_response.json'))).results;
    const tQuery = 'Azab Indosiar';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_list_response.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
