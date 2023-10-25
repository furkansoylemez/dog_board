import 'package:dog_board/core/mapper/mapper.dart';
import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:dog_board/domain/entity/breed.dart';

class BreedMapper extends Mapper<BreedListResponse, List<Breed>> {
  @override
  List<Breed> toEntity(BreedListResponse model) {
    return model.message.entries
        .map((e) => Breed(breed: e.key, subBreeds: e.value))
        .toList();
  }
}
