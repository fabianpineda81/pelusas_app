import 'package:pelusas/domain/datasources/abstract_breeds_datasource.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/domain/repository/abstract_breeds_repository.dart';

class BreedsRepositoryImpl implements AbstractBreedsRepository {
  final AbstractBreedsDatasource datasource;

  BreedsRepositoryImpl(this.datasource);

  @override
  Future<List<BreedEntity>> getCatBreeds() {
    return datasource.getCatBreeds();
  }

  @override
  Future<List<String>> getCatBreedImagesURLs(String breedId) {
    return datasource.getCatBreedImagesURLs(breedId);
  }

  @override
  Future<List<BreedEntity>> searchBreeds(String query) {
    return datasource.searchBreeds(query);
  }
}
