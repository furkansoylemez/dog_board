import 'package:dog_board/data/model/base/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse extends ApiResponse<String> {
  ImageResponse({required super.message, required super.status});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(
    Object Function(String value) toJsonT,
  ) {
    return _$ImageResponseToJson(this);
  }
}
