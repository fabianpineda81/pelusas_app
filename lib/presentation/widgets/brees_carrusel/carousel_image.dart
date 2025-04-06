
import 'package:flutter/material.dart';
import 'package:pelusas/presentation/widgets/cat_image.dart';

class CarouselImage extends StatelessWidget {
  final List<String> imageList;
  final int currentPage;
  final int index;
  const CarouselImage({super.key, required this.imageList, required this.currentPage, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: currentPage == index ? 0 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child:CatImage(urlImage: imageList[index])
      ),
    );
  }
}