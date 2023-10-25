import 'package:dog_board/core/mapper/mapper.dart';
import 'package:dog_board/data/model/image_response.dart';
import 'package:dog_board/domain/entity/random_image.dart';

class RandomImageMapper extends Mapper<ImageResponse, RandomImage> {
  @override
  RandomImage toEntity(ImageResponse model) {
    return RandomImage(image: model.message);
  }
}
