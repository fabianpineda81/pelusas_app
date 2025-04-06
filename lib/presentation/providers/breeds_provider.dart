import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/domain/repository/abstract_breeds_repository.dart';
import 'package:pelusas/infrastructure/datasource/breeds_api_datasource_imple.dart';
import 'package:pelusas/infrastructure/repository/breeds_repository_imple.dart';
import 'package:pelusas/infrastructure/services/dio_service_imple.dart';

final breedsProvider = StateNotifierProvider<BreedsNotifier, AsyncValue<List<BreedEntity>>>((ref) {
  final repository = BreedsRepositoryImpl(BreedApiDatasourceImple(DioServiceImple()));
  return BreedsNotifier(repository);
});

class BreedsNotifier extends StateNotifier<AsyncValue<List<BreedEntity>>> {
  final AbstractBreedsRepository _repository;
  List<BreedEntity> breeds = [];

  BreedsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchBreeds();
  }

  Future<void> fetchBreeds() async {

    if (breeds.isNotEmpty){
      state = AsyncValue.data(breeds);
      return;
    }
    state=AsyncValue.loading();

    try {
      final newBreeds = await _repository.getCatBreeds();
      breeds = newBreeds;
      state = AsyncValue.data(newBreeds);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchBreedsBySearch(String query) async {
    try {
      state = const AsyncValue.loading();
      late final List<BreedEntity> searchedBreeds;

      if(breeds.isEmpty){
         searchedBreeds = await _repository.searchBreeds(query);
      }else{
         searchedBreeds = breeds.where((breed) => breed.name.toLowerCase().contains(query.toLowerCase())).toList();
      }

      state = AsyncValue.data(searchedBreeds);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
  void resetBreeds() {
    state = const AsyncValue.loading();
    fetchBreeds();
  }
}
