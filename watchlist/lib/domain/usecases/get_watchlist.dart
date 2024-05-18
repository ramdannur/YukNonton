import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<WatchlistTable>>> execute(String type) {
    return _repository.getWatchlistByType(type);
  }
}
