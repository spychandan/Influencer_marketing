import 'package:appcreasip/util/consts/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/nextbutton.dart';

class HomeScreen extends StatelessWidget {
  final List<String> carouselImages = [
    'assets/images/about/about_1.jpg',
    'assets/images/about/about_1.jpg',
    'assets/images/about/about_1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor,
        body: Center(
          child: CarouselSlider(
            items: carouselImages.map((imagePath) {
              return Container(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 700,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          ),
        ),
        bottomNavigationBar: NextButton(onPressed: () {
          Navigator.of(context).pushNamed(switchSelectionRoute);
        }));
  }
}
