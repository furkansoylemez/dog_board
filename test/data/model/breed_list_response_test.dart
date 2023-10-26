import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BreedListResponse should correctly serialize and deserialize', () {
    const breedListResponse = BreedListResponse(
      message: {
        'breed': ['sub1', 'sub2'],
      },
      status: 'success',
    );

    final json = {
      'message': {
        'breed': ['sub1', 'sub2'],
      },
      'status': 'success',
    };

    expect(BreedListResponse.fromJson(json), breedListResponse);
    expect(breedListResponse.toJson((value) => value), json);
  });
}
