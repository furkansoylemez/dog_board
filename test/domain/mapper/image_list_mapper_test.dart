import 'package:dog_board/data/model/image_list_response.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/mapper/image_list_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mapper = ImageListMapper();

  test('should correctly map ImageListResponse to ImageList', () {
    const mockResponse =
        ImageListResponse(message: ['image1', 'image2'], status: 'success');

    const expectedOutput = ImageList(images: ['image1', 'image2']);

    final result = mapper.toEntity(mockResponse);

    expect(result, expectedOutput);
  });
}
