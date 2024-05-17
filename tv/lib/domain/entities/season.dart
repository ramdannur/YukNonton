import 'package:equatable/equatable.dart';

class SeasonEntity extends Equatable {
  SeasonEntity({
    required this.id,
    required this.name,
    required this.episodeCount,
  });

  final int id;
  final String name;
  final int episodeCount;

  @override
  List<Object> get props => [id, name, episodeCount];
}
