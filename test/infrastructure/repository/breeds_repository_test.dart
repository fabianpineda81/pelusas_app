import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pelusas/domain/datasources/abstract_breeds_datasource.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/domain/entities/weight.dart';
import 'package:pelusas/infrastructure/repository/breeds_repository_imple.dart';

class MockBreedDataSource extends Mock implements AbstractBreedsDatasource {}
// Datos de prueba: Simulamos lo que la API de gatos nos respondería.
final List<BreedEntity> mockBreeds = [
   BreedEntity(
    id: 'abys',
    name: 'Abyssinian',
    origin: 'Egypt',
    lifeSpanYears: '14 - 15',
    description: 'The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.',
    imagesUrls: ['https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg'],
    adaptability: 5,
    affectionLevel: 5,
    childFriendly: 3,
    dogFriendly: 4,
    energyLevel: 5,
    grooming: 1,
    healthIssues: 2,
    intelligence: 5,
    sheddingLevel: 2,
    socialNeeds: 5,
    strangerFriendly: 5,
    vocalisation: 1,
    experimental: 0,
    hairless: 0,
    natural: 1,
    rare: 0,
    cfaUrl: 'http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx',
    vetstreetUrl: 'http://www.vetstreet.com/cats/abyssinian',
    weight: WeightEntity(imperial: '7 - 10', metric: '3 - 5'),
    rex:0 ,
    suppressedTail: 0,
    shortLegs: 0,
    hypoallergenic: 0,
  ),
   BreedEntity(
    id: 'beng',
    name: 'Bengal',
    origin: 'United States',
    lifeSpanYears: '12 - 15',
    description: 'Bengals are a lot of fun to live with, but they\'re definitely not the cat for everyone, or for first-time cat owners.',
    imagesUrls: ['https://cdn2.thecatapi.com/images/O3bt6KyvD.jpg'],
    adaptability: 5,
    affectionLevel: 5,
    childFriendly: 4,
    dogFriendly: 5,
    energyLevel: 5,
    grooming: 1,
    healthIssues: 3,
    intelligence: 5,
    sheddingLevel: 3,
    socialNeeds: 5,
    strangerFriendly: 3,
    vocalisation: 5,
    experimental: 0,
    hairless: 0,
    natural: 0,
    rare: 0,
    cfaUrl: 'http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx',
    vetstreetUrl: 'http://www.vetstreet.com/cats/abyssinian',
    weight: WeightEntity(imperial: '7 - 10', metric: '3 - 5'),
    rex:0 ,
    suppressedTail: 0,
    shortLegs: 0,
    hypoallergenic: 0,
  ),
];
final List<String> mockImages = [
  'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
];
 void main (){
    late BreedsRepositoryImpl repository;
    late MockBreedDataSource mockDataSource;

    setUp((){
      mockDataSource = MockBreedDataSource();
      repository = BreedsRepositoryImpl(mockDataSource);
    });
    group("getCatBreeds",(){
      test("getCatBreeds devuelve una lista de BreedEntity cuando es extiso", () async {
        when(() => mockDataSource.getCatBreeds()).thenAnswer((_) async => mockBreeds);

        final result = await repository.getCatBreeds();

        expect(result, isA<List<BreedEntity>>());
        expect(result, isNotEmpty);
        expect(result[0], isA<BreedEntity>());
        expect(result[0].id, 'abys');
        verify(() => mockDataSource.getCatBreeds()).called(1);
      });
      test("getCatBreeds devuelve una lista vacia cuando no hay razas", () async {
        when(() => mockDataSource.getCatBreeds()).thenAnswer((_) async => []);
        final result = await repository.getCatBreeds();
        expect(result, isEmpty);
        verify(() => mockDataSource.getCatBreeds()).called(1);
      });
      test("getCatBreeds devuelve una excepcion cuando falla",() async {
        when(() => mockDataSource.getCatBreeds()).thenThrow(Exception());
        expect(() => repository.getCatBreeds(), throwsA(isA<Exception>()));
      });
      //------------------------------------------------------------------------
    });

    group("getCatBreedImagesURLs",(){
      test("getCatBreedImagesURLs devuelve una lista de imagenes", () async {
        when(() => mockDataSource.getCatBreedImagesURLs(any())).thenAnswer((_) async => mockImages);
        final result = await repository.getCatBreedImagesURLs("");
        expect(result, isA<List<String>>());
        verify(() => mockDataSource.getCatBreedImagesURLs(any())).called(1);
      });
      test("getCatBreedImagesURLs devuelve una lista vacia cuando no hay imagenes", () async {
        when(() => mockDataSource.getCatBreedImagesURLs(any())).thenAnswer((_) async => []);
        final result = await repository.getCatBreedImagesURLs("");
        expect(result, isEmpty);
        verify(() => mockDataSource.getCatBreedImagesURLs(any())).called(1);
      });
      test("getCatBreedImagesURLs devuelve una excepcion cuando falla",() async {
        when(() => mockDataSource.getCatBreedImagesURLs(any())).thenThrow(Exception());
        expect(() => repository.getCatBreedImagesURLs("q"), throwsA(isA<Exception>()));
        verify(() => mockDataSource.getCatBreedImagesURLs(any())).called(1);
      });
    });

    group("searchBreeds",() {
      test("searchBreeds devuelve una lista de BreedEntity cuando es extiso", () async {
        when(() => mockDataSource.searchBreeds(any())).thenAnswer((_) async => mockBreeds);
        final result = await repository.searchBreeds("");
        expect(result, isA<List<BreedEntity>>());
      });
      test("searchBreeds devuelve una lista vacia cuando no hay razas", () async {
        when(() => mockDataSource.searchBreeds(any())).thenAnswer((_) async => []);
        final result = await repository.searchBreeds("");
        expect(result, isEmpty);
      });
      test("searchBreeds devuelve una excepcion cuando falla",() async {
        when(() => mockDataSource.searchBreeds(any())).thenThrow(Exception());
        expect(() => repository.searchBreeds(""), throwsA(isA<Exception>()));
      });
    });

 }