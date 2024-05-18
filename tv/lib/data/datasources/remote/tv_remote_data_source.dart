import 'dart:convert';

import 'package:core/common/data/datasources/remote/config.dart';
import 'package:core/common/exception.dart';
import 'package:http/io_client.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<TvDetailResponse> getMovieDetail(int id);
  Future<List<TvModel>> getMovieRecommendations(int id);
  Future<List<TvModel>> getNowPlayingMovies();
  Future<List<TvModel>> getPopularMovies();
  Future<List<TvModel>> getTopRatedMovies();
  Future<List<TvModel>> searchMovies(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const apiKey = theMovieDbApiKey;
  static const baseUrl = theMovieDbBaseUrl;

  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvDetailResponse> getMovieDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getMovieRecommendations(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getNowPlayingMovies() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedMovies() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
