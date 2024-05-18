import 'package:core/common/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int id;
  final String name;

  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [id, name];

  Genre toEntity() {
    return Genre(id: id, name: name);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
