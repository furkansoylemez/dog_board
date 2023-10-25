import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_images_by_sub_breed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/image_list_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;
  late GetImagesBySubBreed getImagesBySubBreed;

  setUp(() {
    mockDogRepository = MockDogRepository();
    getImagesBySubBreed = GetImagesBySubBreed(mockDogRepository);
  });

  test('should get images by sub breed from the dog repository', () async {
    // arrange
    final params = GetImagesBySubBreedParams(breed: '', subBreed: '');
    when(
      () => mockDogRepository.getImagesBySubBreed(
        params.breed,
        params.subBreed,
      ),
    ).thenAnswer((_) async => const Right(tImages));

    // act
    final result = await getImagesBySubBreed(params);

    // assert
    expect(result, const Right<Failure, ImageList>(tImages));
    verify(
      () => mockDogRepository.getImagesBySubBreed(
        params.breed,
        params.subBreed,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockDogRepository);
  });
}
