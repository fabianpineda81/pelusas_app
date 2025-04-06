
import 'package:flutter/material.dart';
import 'package:pelusas/presentation/widgets/brees_carrusel/carousel_image.dart';
import 'package:pelusas/presentation/widgets/brees_carrusel/circular_indicator_corousel.dart';
import 'package:pelusas/presentation/widgets/cat_image.dart';

class BreedCarrousel extends StatefulWidget {
  const BreedCarrousel ({super.key, required this.imageList});
  final List<String> imageList;

  @override
  BreedCarrouselState createState() => BreedCarrouselState();
}

class BreedCarrouselState extends State<BreedCarrousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*.45;
    return Column(
      children: [
        widget.imageList.isNotEmpty?
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return CarouselImage(imageList: widget.imageList, currentPage: _currentPage, index: index);
            },
          ),
        ):CatImage(urlImage:"https://cdn-icons-png.freepik.com/512/5759/5759722.png" ,height: 300, width: 300,),
        const SizedBox(height: 10),
         CircularIndicatorCarousel(imageList: widget.imageList, currentPage: _currentPage),
      ],
    );
  }
}





