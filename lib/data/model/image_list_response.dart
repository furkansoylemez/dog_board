import 'package:dog_board/data/model/base/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_list_response.g.dart';

@JsonSerializable()
class ImageListResponse extends ApiResponse<List<String>> {
  const ImageListResponse({required super.message, required super.status});

  factory ImageListResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(
    Object Function(List<String> value) toJsonT,
  ) {
    return _$ImageListResponseToJson(this);
  }
}
