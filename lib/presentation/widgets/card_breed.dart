import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pelusas/config/router/app_routes.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/presentation/providers/select_provider.dart';
import 'package:pelusas/presentation/widgets/cat_image.dart';

class CardBreed extends ConsumerWidget {
  final BreedEntity breed;

  const CardBreed({
    super.key,
    required this.breed
  });

  @override
  Widget build(BuildContext context,ref) {

    final widthCard = MediaQuery.of(context).size.width*.9;
    final heightCard = MediaQuery.of(context).size.height*.32;
    final colorScheme=Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  breed.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                TextButton.icon(
                  onPressed: () {
                    ref.read(selectedBreedProvider.notifier).state = breed;
                    context.push(AppRoutesEnum.detail.path);
                    },
                  icon: Icon(Icons.info_outline, size: 16),
                  label: Text("Leer más"),

                ),
              ]
              ),
            CatImage(
                urlImage: breed.catImage,
                height: heightCard,
                width: widthCard
            ),
              SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widthCard/3,
                  child:Text(
                    breed.origin,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ) ,
                )
                ,
                Row(
                  children: [
                    Text(
                      "Inteligencia",
                      style: Theme.of(context).textTheme.titleMedium,

                    ),
                    SizedBox(width: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.pets,
                          color: index < breed.intelligence ? colorScheme.surfaceTint : Colors.grey[300],
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
