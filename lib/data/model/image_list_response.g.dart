// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageListResponse _$ImageListResponseFromJson(Map<String, dynamic> json) =>
    ImageListResponse(
      message:
          (json['message'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ImageListResponseToJson(ImageListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
