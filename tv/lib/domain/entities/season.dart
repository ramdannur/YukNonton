import 'package:equatable/equatable.dart';

class SeasonEntity extends Equatable {
  final int id;
  final String name;
  final int episodeCount;
  const SeasonEntity({
    required this.id,
    required this.name,
    required this.episodeCount,
  });

  @override
  List<Object> get props => [id, name, episodeCount];
}
