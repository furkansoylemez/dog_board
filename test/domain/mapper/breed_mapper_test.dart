import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:dog_board/domain/entity/breed.dart';
import 'package:dog_board/domain/mapper/breed_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mapper = BreedMapper();

  test('should correctly map BreedListResponse to List<Breed>', () {
    const mockResponse = BreedListResponse(
      message: {
        'breed1': [],
        'breed2': ['sub1', 'sub2'],
      },
      status: 'success',
    );

    final expectedOutput = [
      const Breed(breed: 'breed1', subBreeds: []),
      const Breed(breed: 'breed2', subBreeds: ['sub1', 'sub2']),
    ];

    final result = mapper.toEntity(mockResponse);

    expect(result, expectedOutput);
  });
}
