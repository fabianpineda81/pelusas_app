import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pelusas/infrastructure/datasource/breeds_api_datasource_imple.dart';
import 'package:pelusas/infrastructure/repository/breeds_repository_imple.dart';
import 'package:pelusas/infrastructure/services/dio_service_imple.dart';

void main(){
  late DioServiceImple badDioService;
  late BreedApiDatasourceImple badDatasource;
  late BreedsRepositoryImpl badRepository;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    badDioService = DioServiceImple();
    badDioService.dio.options.baseUrl="https://10.255.255.1";
    badDatasource = BreedApiDatasourceImple(badDioService);
    badRepository = BreedsRepositoryImpl(badDatasource);
  }, );
  test("Simula un timeout y dispara el interceptor de Dio",  ()async {
    expect(() async => await badRepository.getCatBreeds(), throwsA(
        predicate((e) => e is Exception && e.toString().contains("Tiempo de conexión agotado"))
    ));
  });


}