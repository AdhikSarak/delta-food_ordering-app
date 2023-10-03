import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sundari/constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((e) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            e,
            fit: BoxFit.cover,
            height: 300,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 400),
        autoPlayCurve: Curves.easeInOut,
        autoPlayInterval: const Duration(seconds: 2),
        viewportFraction: 1,
        height: 300,
      ),
    );
  }
}
