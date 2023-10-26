import 'package:dog_board/data/model/base/api_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApiResponse should correctly serialize and deserialize', () {
    const apiResponse = ApiResponse<String>(
      message: 'Test',
      status: 'success',
    );

    final json = {
      'message': 'Test',
      'status': 'success',
    };

    expect(ApiResponse.fromJson(json, (json) => json! as String), apiResponse);
    expect(apiResponse.toJson((value) => value), json);
  });
}
