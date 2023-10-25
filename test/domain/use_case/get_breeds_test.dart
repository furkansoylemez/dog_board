import 'package:dartz/dartz.dart';
import 'package:dog_board/core/error/failures.dart';
import 'package:dog_board/core/use_case/use_case.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/repository/dog_repository.dart';
import 'package:dog_board/domain/use_case/get_breeds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/breed_fixture.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late MockDogRepository mockDogRepository;
  late GetBreeds getBreeds;

  setUp(() {
    mockDogRepository = MockDogRepository();
    getBreeds = GetBreeds(mockDogRepository);
  });

  test('should get breeds from the dog repository', () async {
    // arrange
    when(() => mockDogRepository.getBreeds())
        .thenAnswer((_) async => Right(tBreeds));

    // act
    final result = await getBreeds(NoParams());

    // assert
    expect(result, Right<Failure, List<Breed>>(tBreeds));
    verify(() => mockDogRepository.getBreeds()).called(1);
    verifyNoMoreInteractions(mockDogRepository);
  });
}
