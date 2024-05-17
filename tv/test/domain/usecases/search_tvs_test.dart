import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvs(mockTvRepository);
  });

  final tvs = <Tv>[];
  const tQuery = 'Sinetron azab';

  test('should get list of TV Show from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tvs));
  });
}
