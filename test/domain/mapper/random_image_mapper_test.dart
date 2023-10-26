import 'package:dog_board/data/model/image_response.dart';
import 'package:dog_board/domain/entity/random_image.dart';
import 'package:dog_board/domain/mapper/random_image_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mapper = RandomImageMapper();

  test('should correctly map ImageResponse to RandomImage', () {
    const mockResponse =
        ImageResponse(message: 'randomImage', status: 'success');

    const expectedOutput = RandomImage(image: 'randomImage');

    final result = mapper.toEntity(mockResponse);

    expect(result, expectedOutput);
  });
}
