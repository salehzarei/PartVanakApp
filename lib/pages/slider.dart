import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Sliderr extends StatefulWidget {
  @override
  _SliderrState createState() => _SliderrState();
}

class _SliderrState extends State<Sliderr> {
  final List<String> image = [
    'images/air.jpg',
    'images/logo.jpg',
    'images/profile.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return _slider();
  }
  _slider(){
     Container(
        child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network('https://images.unsplash.com/photo-1530908295418-a12e326966ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
        );
      },
      itemCount: 3,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: SwiperPagination(),
    ));
  }
}
