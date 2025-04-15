import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pelusas/infrastructure/models/breed_model.dart';
import 'package:pelusas/presentation/pages/detail_breed/breed_detail_screen.dart';
import 'package:pelusas/presentation/providers/select_provider.dart';
import 'package:pelusas/presentation/widgets/brees_carrusel/breeds_carrusel.dart';

import '../../../mokModels/data.dart';





void main(){
  testWidgets('mostrar el detalle de la raza correctamente', (WidgetTester tester) async {
    final mockModels = mockAllbreeds.map((e) => BreedModel.fromJson(e)).toList();
    final breedEntity=mockModels.first.toEntity(listImage);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [selectedBreedProvider.overrideWith( (ref) {return breedEntity;},)],
        child: const MaterialApp(
          home: BreedDetailScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(breedEntity.name), findsAny);
  });

  testWidgets('mostrar las imagenes de la raza correctamente', (WidgetTester tester) async {
    final mockModels = mockAllbreeds.map((e) => BreedModel.fromJson(e)).toList();
    final breedEntity=mockModels.first.toEntity(listImage);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [selectedBreedProvider.overrideWith( (ref) {return breedEntity;},)],
        child: const MaterialApp(
          home: BreedDetailScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(BreedCarrousel), findsOne);
  });

  testWidgets('mostrar las imagenes de la raza correctamente aunque no tenga imagenes', (WidgetTester tester) async {
    final mockModels = mockAllbreeds.map((e) => BreedModel.fromJson(e)).toList();
    final breedEntity=mockModels.first.toEntity([]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [selectedBreedProvider.overrideWith( (ref) {return breedEntity;},)],
        child: const MaterialApp(
          home: BreedDetailScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(BreedCarrousel), findsOne);
  });
}




