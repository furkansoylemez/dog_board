import 'package:dog_board/core/mapper/mapper.dart';
import 'package:dog_board/data/model/image_list_response.dart';
import 'package:dog_board/domain/entity/image_list.dart';

class ImageListMapper extends Mapper<ImageListResponse, ImageList> {
  @override
  ImageList toEntity(ImageListResponse model) {
    return ImageList(images: model.message);
  }
}
