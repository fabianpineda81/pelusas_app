
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/presentation/providers/breeds_provider.dart';
import 'package:pelusas/presentation/widgets/card_breed.dart';
import 'package:pelusas/presentation/widgets/cat_loader.dart';
import 'package:pelusas/presentation/widgets/error_screen.dart';
import 'package:pelusas/presentation/widgets/search_bar.dart';

class BreedsHomePage extends ConsumerWidget {
  const BreedsHomePage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final breedsState = ref.watch(breedsProvider);
    return Scaffold(
      appBar: BreedSearchAppBar(),
      body: breedsState.when(
            loading: () => const Center(child: CatLoader()),
              error: (error, _) => ErrorScreen(onRetry: () {
                ref.read(breedsProvider.notifier).fetchBreeds();
              },),
              data: (breeds) => ListView.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  final breed = breeds[index];
                  return CardBreed(
                      breed: breed,
                  );
                },
              ),
            ),


    );
  }

}
