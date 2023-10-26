import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:dog_board/domain/entity/breed.dart';

final tAllBreedsResponse = BreedListResponse(
  message: {
    'affenpinscher': [],
    'african': [],
    'airedale': [],
    'akita': [],
    'australian': ['shepherd'],
    'basenji': [],
    'beagle': [],
    'borzoi': [],
    'boxer': [],
    'briard': [],
    'bulldog': ['boston', 'english', 'french'],
  },
  status: 'success',
);

final tBreeds = [
  const Breed(breed: 'affenpinscher', subBreeds: ['test11', 'test22']),
  const Breed(breed: 'african', subBreeds: ['test1', 'test2']),
  const Breed(breed: 'airedale', subBreeds: []),
  const Breed(breed: 'akita', subBreeds: []),
  const Breed(breed: 'australian', subBreeds: ['shepherd']),
  const Breed(breed: 'basenji', subBreeds: []),
  const Breed(breed: 'beagle', subBreeds: []),
  const Breed(breed: 'borzoi', subBreeds: []),
  const Breed(breed: 'boxer', subBreeds: []),
  const Breed(breed: 'briard', subBreeds: []),
  const Breed(breed: 'bulldog', subBreeds: ['boston', 'english', 'french']),
];

const tBreedEntity = Breed(breed: 'australian', subBreeds: ['shepherd']);

final tBreedsWithSubBreeds = [
  const Breed(breed: 'australian', subBreeds: ['test11', 'test22']),
  const Breed(breed: 'bulldog', subBreeds: ['boston', 'english', 'french']),
];

const tBreed = 'australian';

const tSubBreed = 'shepherd';
