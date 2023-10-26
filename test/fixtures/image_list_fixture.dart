import 'package:dog_board/data/model/image_list_response.dart';
import 'package:dog_board/data/model/image_response.dart';
import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/domain/entity/random_image.dart';

const tImagesListResponse = ImageListResponse(
  message: [
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1009.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1023.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_104.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1040.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_105.jpg',
  ],
  status: 'success',
);

const tImages = ImageList(
  images: [
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1009.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1023.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_104.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1040.jpg',
    'https://images.dog.ceo/breeds/bulldog-boston/n02096585_105.jpg',
  ],
);

const tImageResponse = ImageResponse(
  message: 'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1009.jpg',
  status: 'success',
);

const tRandomImage = RandomImage(
  image: 'https://images.dog.ceo/breeds/bulldog-boston/n02096585_1009.jpg',
);
