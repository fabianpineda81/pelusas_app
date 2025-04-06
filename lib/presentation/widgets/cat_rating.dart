import 'package:flutter/material.dart';

class CatRating extends StatelessWidget {
  final int rating;
  final String labelRating;
  const CatRating({super.key, required this.rating, required this.labelRating});


  @override
  Widget build(BuildContext context) {
    final colorScheme=Theme.of(context).colorScheme;
    final widthRating = MediaQuery.of(context).size.width;
    return  Row(
      children: [
      SizedBox(
          width: widthRating/2,
          child:
            Text(
              labelRating,
              style: Theme.of(context).textTheme.titleMedium,

            )
      ),
        SizedBox(width: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return Icon(
              Icons.pets,
              color: index < rating ? colorScheme.surfaceTint : Colors.grey[300],
              size: 25,
            );
          }),
        ),
      ],
    );
  }
}
