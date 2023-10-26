import 'package:dio/dio.dart';
import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:dog_board/data/model/image_list_response.dart';
import 'package:dog_board/data/model/image_response.dart';
import 'package:retrofit/retrofit.dart';

part 'dog_client.g.dart';

@RestApi(baseUrl: 'https://dog.ceo/api/')
abstract class DogClient {
  factory DogClient(Dio dio, {String baseUrl}) = _DogClient;

  @GET('breeds/list/all')
  Future<BreedListResponse> getBreeds();

  @GET('breed/{breed}/images')
  Future<ImageListResponse> getImagesByBreed(@Path('breed') String breed);

  @GET('breed/{breed}/{subBreed}/images')
  Future<ImageListResponse> getImagesBySubBreed(
    @Path('breed') String breed,
    @Path('subBreed') String subBreed,
  );

  @GET('breed/{breed}/images/random')
  Future<ImageResponse> getRandomImageByBreed(@Path('breed') String breed);

  @GET('breed/{breed}/{subBreed}/images/random')
  Future<ImageResponse> getRandomImageBySubBreed(
    @Path('breed') String breed,
    @Path('subBreed') String subBreed,
  );
}
