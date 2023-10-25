import 'package:dog_board/data/model/base/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'breed_list_response.g.dart';

@JsonSerializable()
class BreedListResponse extends ApiResponse<Map<String, List<String>>> {
  BreedListResponse({required super.message, required super.status});

  factory BreedListResponse.fromJson(Map<String, dynamic> json) =>
      _$BreedListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(
    Object Function(Map<String, List<String>> value) toJsonT,
  ) {
    return _$BreedListResponseToJson(this);
  }
}
