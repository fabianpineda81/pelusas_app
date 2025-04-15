import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pelusas/domain/datasources/abstract_breeds_datasource.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/infrastructure/datasource/breeds_api_datasource_imple.dart';
import 'package:pelusas/infrastructure/repository/breeds_repository_imple.dart';
import 'package:pelusas/infrastructure/services/dio_service_imple.dart';

import '../../mokModels/data.dart';



class MockDio extends Mock implements Dio {}
class MockDioService extends Mock implements DioServiceImple {}



void main() {
  late BreedsRepositoryImpl repository;
  late AbstractBreedsDatasource datasource;
  late MockDioService mockDioService;
  late MockDio mockDio;
  setUp(() async {
    mockDio = MockDio();
    mockDioService = MockDioService();
    datasource= BreedApiDatasourceImple(mockDioService);
    repository = BreedsRepositoryImpl(datasource);
    when(() => mockDioService.dio).thenReturn(mockDio);


  });
  
  group('Pruebas de BreedsRepository', () {
    test('Repository devuelve una lista de razas correctamente', () async {
      final responseBreeds = Response(
        requestOptions: RequestOptions(path: "https://api.thecatapi.com/v1/"),
        data: mockAllbreeds,
        statusCode: 200,
      );
      configImages(mockDio);
      when(() => mockDio.get('/breeds')).thenAnswer((_) async => responseBreeds);


      final result = await repository.getCatBreeds();

      expect(result, isA<List<BreedEntity>>());
      expect(result.first.catImage,isA<String>());

    });

    test("Repository devuelve una lista de razas al buscar por nombre", ()async{
      final response = Response(
        requestOptions: RequestOptions(path: "https://api.thecatapi.com/v1/"),
        data: mockBreedsByname,
        statusCode: 200,
      );
      configImages(mockDio);
      when(() => mockDio.get( '/breeds/search', queryParameters: {'q': 'Abyssinian'})).thenAnswer((_) async => response);

      final result = await repository.searchBreeds("Abyssinian");

      expect(result.first, isA<BreedEntity>());

    });
    test("Repository devuelve una lista vacia de razas al buscar por nombre", ()async{
      final response = Response(
        requestOptions: RequestOptions(path: "https://api.thecatapi.com/v1/"),
        data: mockBreedsBynameEmpy,
        statusCode: 200,
      );
      configImages(mockDio);
      when(() => mockDio.get( '/breeds/search', queryParameters: {'q': 'empyBreed'})).thenAnswer((_) async => response);

      final result = await repository.searchBreeds("empyBreed");

      expect(result, isA<List<BreedEntity>>());

    });
    test("Repository devuelve una lista de url de imagenes al buscar por id", ()async{
      configImages(mockDio);
      final result= await repository.getCatBreedImagesURLs("abys");
      expect(result, isA<List<String>>());
    });

  });


}



void configImages(MockDio mockDio) {

  final responseImage= Response(
    requestOptions: RequestOptions(path: "https://api.thecatapi.com/v1/"),
    data: mockBreedsImgByid,
    statusCode: 200,
  );
  when(() => mockDio.get('/images/search', queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => responseImage);
}