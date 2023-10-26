import 'package:dog_board/data/model/image_list_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ImageListResponse should correctly serialize and deserialize', () {
    const imageListResponse = ImageListResponse(
      message: ['img1.jpg', 'img2.jpg'],
      status: 'success',
    );

    final json = {
      'message': ['img1.jpg', 'img2.jpg'],
      'status': 'success',
    };

    expect(ImageListResponse.fromJson(json), imageListResponse);
    expect(imageListResponse.toJson((value) => value), json);
  });
}
