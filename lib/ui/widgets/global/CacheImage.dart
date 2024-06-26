import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  CachedImage(this.url, {this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) =>  Image.asset(
        'Assets/Illustrations/default.jpg',
        width: width,
        height: height,
      ),
      width: width,
      height: height,
      imageUrl: url,
      fit: BoxFit.fill,
      placeholder: (_, __) => Image.asset(
        'Assets/Illustrations/default.jpg',
        width: width,
        height: height,
      ),
    );
  }
}
