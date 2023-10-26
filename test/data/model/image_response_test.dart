import 'package:dog_board/data/model/image_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ImageResponse should correctly serialize and deserialize', () {
    const imageResponse = ImageResponse(
      message: 'img1.jpg',
      status: 'success',
    );

    final json = {
      'message': 'img1.jpg',
      'status': 'success',
    };

    expect(ImageResponse.fromJson(json), imageResponse);
    expect(imageResponse.toJson((value) => value), json);
  });
}
