import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/domain/datasources/abstract_breeds_datasource.dart';
import 'package:pelusas/domain/services/abstract_dio_service.dart';
import 'package:pelusas/infrastructure/models/breed_model.dart';

class BreedApiDatasourceImple extends AbstractBreedsDatasource {
  final AbstractDioService dioService;

  BreedApiDatasourceImple(this.dioService);

  @override
  Future<List<BreedEntity>> getCatBreeds() async {
    try {
      final response = await dioService.dio.get('/breeds');
      final List data = response.data;

      List<BreedModel> breeds = data.map((json) => BreedModel.fromJson(json)).toList();

      final breedsWithImages = await Future.wait(
          breeds.map((breed) async {
            try {
              final images = await getCatBreedImagesURLs(breed.id);
              return breed.toEntity(images);
            } catch (e) {
              return breed.toEntity([]);
            }
          })
      );
      return breedsWithImages;
    } catch (e) {
      throw Exception('Error al obtener razas de gatos: $e');
    }
  }

  @override
  Future<List<String>> getCatBreedImagesURLs(String breedId) async {
    try {
      final response = await dioService.dio.get('/images/search', queryParameters: {
        'breed_id': breedId,
        'limit': 10,
      });

      final List data = response.data;

      return data.map<String>((item) => item['url'] as String).toList();
    } catch (e) {
      throw Exception('Error al obtener imágenes: $e');
    }
  }

  @override
  Future<List<BreedEntity>> searchBreeds(String query) async {
    try {
      final response = await dioService.dio.get('/breeds/search', queryParameters: {
        'q': query,
      });

      final List data = response.data;
      List<BreedModel> breeds = data.map((json) => BreedModel.fromJson(json)).toList();

      final breedsWithImages = await Future.wait(
          breeds.map((breed) async {
            final images = await getCatBreedImagesURLs(breed.id);
            return breed.toEntity(images);
          })
      );
      return breedsWithImages;

    } catch (e) {
      throw Exception('Error al buscar razas: $e');
    }
  }
}
