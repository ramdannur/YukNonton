import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tvId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getDetailTv(tvId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tvId);
    // assert
    expect(result, Right(testTvDetail));
  });
}