import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/domain/entities/weight.dart';
import 'package:pelusas/domain/repository/abstract_breeds_repository.dart';
import 'package:pelusas/presentation/providers/breeds_provider.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';

// 1. Mock del repositorio (ya sabes hacer esto)
class MockBreedsRepository extends Mock implements AbstractBreedsRepository {}

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

void main() {
  late MockBreedsRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockBreedsRepository();

    // 2. Creamos el contenedor de Riverpod
    container = ProviderContainer(
      overrides: [
        // ¡MAGIA!: Sobrescribimos el provider para que use nuestro mock
        // en lugar de la implementación real.
        breedsProvider.overrideWith((ref) => BreedsNotifier(mockRepository)),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('BreedsNotifier', () {
    test('el estado inicial debe ser loading y luego data al cargar exitosamente al cargar las razas', () async {
      // Arrange
      final List<BreedEntity> mockList = []; // Puedes usar tus mockBreeds aquí
      when(() => mockRepository.getCatBreeds()).thenAnswer((_) async => mockList);

      // Act & Assert
      // Al crear el notifier (en el setUp), ya se llama a fetchBreeds()

      // Verificamos que eventualmente el estado sea Data
      final state = container.read(breedsProvider);
      expect(state, isA<AsyncLoading>());

      // Esperamos a que la operación asíncrona termine
      await container.read(breedsProvider.notifier).fetchBreeds();

      final finalState = container.read(breedsProvider);
      expect(finalState.value, mockList);
      expect(finalState, isA<AsyncData>());
    });

    test('debe emitir AsyncError cuando el repositorio falla al buscar todas las razas ', () async {
      // Arrange
      when(() => mockRepository.getCatBreeds()).thenThrow(Exception('Error de red'));

      // Act
      await container.read(breedsProvider.notifier).fetchBreeds();

      // Assert
      final state = container.read(breedsProvider);
      expect(state, isA<AsyncError>());
    });

    test('debe emitir AsyncError cuando el repositorio falla al buscar por raza ', () async {
      // Arrange
      final query = "abs";
      // ✅ CORRECCIÓN: Mockeamos searchBreeds que es el que se usa internamente
      when(() => mockRepository.searchBreeds(query))
          .thenThrow(Exception('Error de red'));

      // También mockeamos getCatBreeds por la llamada del constructor
      when(() => mockRepository.getCatBreeds()).thenAnswer((_) async => []);

      // Act
      await container.read(breedsProvider.notifier).fetchBreedsBySearch(query);

      // Assert
      final state = container.read(breedsProvider);
      expect(state, isA<AsyncError>());
      verify(() => mockRepository.searchBreeds(query)).called(1);
    });

    test('debe filtrar localmente (sin llamar a la API) cuando ya hay razas cargadas', () async {
      // Arrange
      final query = "Abys";


      // Seteamos el estado inicial con datos
      final notifier = container.read(breedsProvider.notifier);
      notifier.breeds = mockBreeds; // Llenamos la cache local

      // Act
      await notifier.fetchBreedsBySearch(query);

      // Assert
      final state = container.read(breedsProvider);
      expect(state.value!.length, 1);
      expect(state.value![0].name, 'Abyssinian');

      // ✅ CLAVE: Verificamos que NUNCA llamó a la API de búsqueda
      verifyNever(() => mockRepository.searchBreeds(any()));
    });

    test('debe resetear el estado y volver a cargar todas las razas', () async {
      // Arrange
      when(() => mockRepository.getCatBreeds()).thenAnswer((_) async => []);

      // Act
      await container.read(breedsProvider.notifier).resetBreeds();

      // Assert
      final state = container.read(breedsProvider);
      expect(state, isA<AsyncData>());
      // Verificamos que resetBreeds disparó fetchBreeds
      verify(() => mockRepository.getCatBreeds()).called(1); // 1 del constructor + 1 del reset
    });

    test('el estado inicial debe ser loading y luego data al cargar exitosamente resetear el estado del notifier', () async {
      // Arrange
      final query ="abs";
      final List<BreedEntity> mockList = []; // Puedes usar tus mockBreeds aquí
      when(() => mockRepository.searchBreeds(query)).thenAnswer((_) async => mockList);
      when(() => mockRepository.getCatBreeds()).thenAnswer((_) async => []);


      // Act & Assert
      // Al crear el notifier (en el setUp), ya se llama a fetchBreeds()
      await container.read(breedsProvider.notifier).fetchBreedsBySearch(query);
      final stateInitial = container.read(breedsProvider);
      expect(stateInitial, isA<AsyncData>());
      // Verificamos que eventualmente el estado sea Data
      await container.read(breedsProvider.notifier).resetBreeds();
      final state = container.read(breedsProvider);
      expect(state.value, []);
      expect(state, isA<AsyncData>());
    });
  });
}


