import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/config/utils.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/presentation/providers/select_provider.dart';
import 'package:pelusas/presentation/widgets/brees_carrusel/breeds_carrusel.dart';
import 'package:pelusas/presentation/widgets/cat_rating.dart';

class BreedDetailScreen extends ConsumerWidget {
  const BreedDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final BreedEntity breed= ref.read(selectedBreedProvider)! ;
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body:  Column(
          children: [
            BreedCarrousel(imageList: breed.imagesUrls),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("País de origen: ${breed.origin}", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text("Duración de vida: ${breed.lifeSpanYears}", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text("Peso: ${breed.weight.metric} kg", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text("Descripción:",
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(breed.description ),

                      const SizedBox(height: 16),
                      Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Caracteristicas:",
                                    style: Theme.of(context).textTheme.titleMedium),
                                CatRating(rating: breed.adaptability, labelRating: "Adaptabilidad"),
                                CatRating(rating: breed.intelligence, labelRating: "Inteligencia"),
                                CatRating(rating: breed.socialNeeds, labelRating: "Necesidades sociales"),
                                CatRating(rating: breed.affectionLevel, labelRating: "Nivel de amor"),
                                CatRating(rating: breed.childFriendly, labelRating: "Amistoso con niños"),
                                CatRating(rating: breed.dogFriendly, labelRating: "Amistoso con perros"),
                                CatRating(rating: breed.energyLevel, labelRating: "Nivel de energía"),
                                CatRating(rating: breed.grooming, labelRating: "Limpieza"),
                                CatRating(rating: breed.sheddingLevel, labelRating: "Nivel de pelaje"),
                                CatRating(rating: breed.vocalisation, labelRating: "Vocación"),
                                CatRating(rating: breed.experimental, labelRating: "Experimentado"),
                              ],
                            ),
                          )
                      ),
                      const SizedBox(height: 16),
                      Text("Referencias:", style: Theme.of(context).textTheme.titleMedium),

                      if (breed.cfaUrl != null)
                        TextButton(
                          onPressed: () => Utils.safeLaunchUrl(breed.cfaUrl!),
                          child: Text(breed.cfaUrl!),
                        ),
                      if (breed.vetstreetUrl != null)
                        TextButton(
                          onPressed: () => Utils.safeLaunchUrl(breed.vetstreetUrl!),
                          child: Text(breed.vetstreetUrl!),
                        ),
                      if (breed.vcahospitalsUrl != null)
                        TextButton(
                          onPressed: () => Utils.safeLaunchUrl(breed.vcahospitalsUrl!),
                          child: Text(breed.vcahospitalsUrl!),
                        ),
                      if (breed.wikipediaUrl != null)
                        TextButton(
                          onPressed: () => Utils.safeLaunchUrl(breed.wikipediaUrl!),
                          child: Text(breed.wikipediaUrl!),
                        ),

                    ],
                  ),
                ),
              ),
            )
           ,
          ],
        ),

    );
  }
}


