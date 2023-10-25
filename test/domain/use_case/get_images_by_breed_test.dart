import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_images_by_breed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/image_list_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;
  late GetImagesByBreed getImagesByBreed;

  setUp(() {
    mockDogRepository = MockDogRepository();
    getImagesByBreed = GetImagesByBreed(mockDogRepository);
  });

  test('should get images by breed from the dog repository', () async {
    // arrange
    final params = GetImagesByBreedParams(breed: '');
    when(() => mockDogRepository.getImagesByBreed(params.breed))
        .thenAnswer((_) async => const Right(tImages));

    // act
    final result = await getImagesByBreed(params);

    // assert
    expect(result, const Right<Failure, ImageList>(tImages));
    verify(() => mockDogRepository.getImagesByBreed(params.breed)).called(1);
    verifyNoMoreInteractions(mockDogRepository);
  });
}
