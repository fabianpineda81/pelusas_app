
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pelusas/domain/repository/abstract_breeds_repository.dart';
import 'package:pelusas/infrastructure/models/breed_model.dart';
import 'package:pelusas/presentation/pages/home_breeds/breeds_home_page.dart';
import 'package:pelusas/presentation/widgets/card_breed.dart';
import 'package:pelusas/presentation/widgets/cat_loader.dart';
import 'package:pelusas/presentation/providers/breeds_provider.dart';
import 'package:pelusas/presentation/widgets/error_screen.dart';

import '../../../mokModels/data.dart';


class _FakeRepository extends Mock implements AbstractBreedsRepository{}

class FakeBreedsLoadingNotifier extends BreedsNotifier {
  FakeBreedsLoadingNotifier() : super(_FakeRepository()) {
    state =const AsyncValue.loading();
  }
}
class FakeBreedsValueNotifier extends BreedsNotifier {
  FakeBreedsValueNotifier() : super(_FakeRepository()) {
    final mockModels = mockAllbreeds.map((e) => BreedModel.fromJson(e)).toList();
    state = AsyncValue.data(mockModels.map((e)=> e.toEntity(listImage)).toList());
  }
}

class FakeBreedsErrorNotifier extends BreedsNotifier {
  FakeBreedsErrorNotifier() : super(_FakeRepository()) {
    state = AsyncValue.error(Exception('Error de prueba'), StackTrace.current);
  }
}



void main() {
  group('BreedsHomePage', ()
  {
    testWidgets(
        'Muestra CatLoader cuando esta cargando', (WidgetTester tester) async {

      await tester.pumpWidget(
        ProviderScope(
          overrides: [breedsProvider.overrideWith((ref) {
            return FakeBreedsLoadingNotifier();
          },)
          ],
          child: const MaterialApp(
            home: BreedsHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CatLoader), findsOneWidget);
    });

    testWidgets('Muestra la lista de cardBreeds correctamente', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [breedsProvider.overrideWith((ref) {
            return FakeBreedsValueNotifier();
          },)
          ],
          child: const MaterialApp(
            home: BreedsHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CardBreed), findsAny);
    });

    testWidgets('Muestra la pantalla errorScrean cuando sucede un error al cargar las razas', (
        WidgetTester tester) async {

      await tester.pumpWidget(
        ProviderScope(
          overrides: [breedsProvider.overrideWith((ref) {
            return FakeBreedsErrorNotifier();
          },)
          ],
          child: const MaterialApp(
            home: BreedsHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CardBreed), findsNothing);
      expect(find.byType(ErrorScreen), findsOneWidget);
    });
  });
}
