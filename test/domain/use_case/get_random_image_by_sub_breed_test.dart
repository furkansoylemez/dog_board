import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_random_image_by_sub_breed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/random_image_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;
  late GetRandomImageBySubBreed getRandomImageBySubBreed;

  setUp(() {
    mockDogRepository = MockDogRepository();
    getRandomImageBySubBreed = GetRandomImageBySubBreed(mockDogRepository);
  });

  test('should get random image by sub breed from the dog repository',
      () async {
    // arrange
    final params = GetRandomImageBySubBreedParams(breed: '', subBreed: '');
    when(
      () => mockDogRepository.getRandomImageBySubBreed(
        params.breed,
        params.subBreed,
      ),
    ).thenAnswer((_) async => const Right(tRandomImage));

    // act
    final result = await getRandomImageBySubBreed(params);

    // assert
    expect(result, const Right<Failure, RandomImage>(tRandomImage));
    verify(
      () => mockDogRepository.getRandomImageBySubBreed(
        params.breed,
        params.subBreed,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockDogRepository);
  });
}
