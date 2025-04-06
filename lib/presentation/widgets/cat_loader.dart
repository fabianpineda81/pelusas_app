import 'package:flutter/material.dart';

  class CatLoader extends StatelessWidget {
  final double? width;
  final double? height;
  const CatLoader({super.key,
     this.width,
     this.height
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/cat_loader.gif',
        width: width??150,
        height: height??150,
      ),
    );
  }
}
