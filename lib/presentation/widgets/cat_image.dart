import 'package:flutter/material.dart';
import 'package:pelusas/presentation/widgets/cat_loader.dart';

class CatImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String urlImage;
  const CatImage({super.key, this.height, this.width, required this.urlImage});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: Image.network(
        urlImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: height,
          width: width,
          color: Colors.grey[300],
          child: Image.asset(
            'assets/cat_sad.png',
            width: 200,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CatLoader(width: width, height: height);
        },
      ),
    );
  }
}
