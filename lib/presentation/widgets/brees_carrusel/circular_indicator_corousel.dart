import 'package:flutter/material.dart';

class CircularIndicatorCarousel extends StatelessWidget {
  final List<String> imageList;
  final int currentPage;

  const CircularIndicatorCarousel({super.key, required this.imageList, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(imageList.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: currentPage == index ? 12 : 8,
          height: currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? colorScheme.surfaceTint : colorScheme.onSurface,
          ),
        );
      }),
    );
  }
}