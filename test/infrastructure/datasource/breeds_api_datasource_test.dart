import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/domain/services/abstract_dio_service.dart';
import 'package:pelusas/infrastructure/datasource/breeds_api_datasource_imple.dart';

// --- PASO 1: DEFINICIÓN DE MOCKS ---
// Usamos Mocktail para crear versiones "falsas" de nuestras dependencias.
// Esto permite probar el Datasource sin depender de una conexión real a internet
// o de que la clase Dio funcione correctamente.
class MockDio extends Mock implements Dio {}
class MockDioService extends Mock implements AbstractDioService {}

// Datos de prueba: Simulamos lo que la API de gatos nos respondería.
final mockBreedsJson = [
  {
    "id": "abys",
    "name": "Abyssinian",
    "origin": "Egypt",
    "weight": {"metric": "3 - 5"},
    "life_span": "14 - 15",
    "description": "Desc...",
    // Faltan campos que tu modelo espera, pero el modelo tiene valores por defecto (?? 0)
  }
];

final mockImagesJson = [
  {"url": "https://cdn.com/cat1.jpg"}
];

void main() {
  // Declaramos las variables que usaremos en los tests.
  // 'late' porque se inicializarán en el setUp.
  late BreedApiDatasourceImple datasource;
  late MockDioService mockDioService;
  late MockDio mockDio;
  late Response responseBreeds;
  late Response responseImages;

  setUpAll((){
     responseBreeds = Response(
      data: mockBreedsJson,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/breeds'),
    );

      responseImages = Response(
      data: mockImagesJson,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/images/search'),
    );
  });

  // El setUp se ejecuta ANTES de cada test individual.
  // Sirve para reiniciar el estado y que un test no afecte al siguiente.
  setUp(() {
    mockDio = MockDio();
    mockDioService = MockDioService();

    // "Entrenamos" al MockDioService para que cuando alguien pida su propiedad .dio,
    // devuelva nuestro MockDio en lugar de uno real.
    when(() => mockDioService.dio).thenReturn(mockDio);

    // Inyectamos el mock en la implementación.
    datasource = BreedApiDatasourceImple(mockDioService);
  });

  // group: Sirve para organizar los tests por método o funcionalidad.
  group('getCatBreeds', () {

    test('debe retornar una lista de BreedEntity cuando la respuesta es exitosa (200)', () async {
      // --- ARRANGE (Preparar) ---
      // Configuramos las respuestas ficticias de Dio.


      // Le decimos a Mocktail qué hacer cuando se llamen a ciertos endpoints.
      // any(named: 'queryParameters') permite que el test pase sin importar qué parámetros se envíen.
      when(() => mockDio.get('/breeds')).thenAnswer((_) async => responseBreeds);
      when(() => mockDio.get('/images/search', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => responseImages);

      // --- ACT (Actuar) ---
      // Ejecutamos el método que realmente queremos probar.
      final result = await datasource.getCatBreeds();

      // --- ASSERT (Verificar) ---
      // Comprobamos que el resultado sea lo que esperamos.
      expect(result, isNotEmpty);
      expect(result[0], isA<BreedEntity>());
      expect(result[0].imagesUrls[0], contains('https://cdn.com/cat1.jpg'));

      // verify: Asegura que el código realmente llamó a la API.
      // Si el código no llamara a /breeds, este test fallaría aquí.
      verify(() => mockDio.get('/breeds')).called(1);
    });

    test('debe lanzar una Exception cuando la respuesta de Dio falla', () async {
      // --- ARRANGE ---
      // Simulamos un error de red o de servidor.
      when(() => mockDio.get('/breeds')).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/breeds'))
      );

      // --- ACT & ASSERT ---
      // En Dart, para probar excepciones, pasamos una función anónima al expect.
      expect(() => datasource.getCatBreeds(), throwsA(isA<Exception>()));
    });
  });
  group('buscar razas por nombre', () {

    test('debe lanzar una Exception cuando la respuesta de Dio falla', () async {
      // --- ARRANGE ---
      // Simulamos un error de red o de servidor.
      final query = 'Abyssinian';
      when(() => mockDio.get('/breeds/search', queryParameters: {'q': query})).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/breeds'))
      );

      // --- ACT & ASSERT ---
      // En Dart, para probar excepciones, pasamos una función anónima al expect.
      expect(() => datasource.searchBreeds(query), throwsA(isA<Exception>()));
    });

    test('debe devolver una lista de breeds cuando se busca por nombre (query)', () async {
      // --- ARRANGE ---
      final query = 'Abyssinian';
      when(() => mockDio.get('/breeds/search', queryParameters: {'q': query})).thenAnswer((_) async => responseBreeds);
      when(() => mockDio.get('/images/search', queryParameters: any(named: 'queryParameters'))).thenAnswer((_)async => responseImages);
      // --- ACT ---
      final result = await datasource.searchBreeds(query);
      // --- ASSERT ---
      expect(result, isNotEmpty);
      expect(result[0], isA<BreedEntity>());
      expect(result[0].imagesUrls[0], contains('https://cdn.com/cat1.jpg'));
      verify(() => mockDio.get('/breeds/search', queryParameters: {'q': query}),).called(1);
    });
  });
}