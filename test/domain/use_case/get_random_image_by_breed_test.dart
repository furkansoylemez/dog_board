import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_random_image_by_breed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/random_image_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;
  late GetRandomImageByBreed getRandomImageByBreed;

  setUp(() {
    mockDogRepository = MockDogRepository();
    getRandomImageByBreed = GetRandomImageByBreed(mockDogRepository);
  });

  test('should get random image by breed from the dog repository', () async {
    // arrange
    final params = GetRandomImageByBreedParams(breed: '');
    when(() => mockDogRepository.getRandomImageByBreed(params.breed))
        .thenAnswer((_) async => const Right(tRandomImage));

    // act
    final result = await getRandomImageByBreed(params);

    // assert
    expect(result, const Right<Failure, RandomImage>(tRandomImage));
    verify(() => mockDogRepository.getRandomImageByBreed(params.breed))
        .called(1);
    verifyNoMoreInteractions(mockDogRepository);
  });
}
