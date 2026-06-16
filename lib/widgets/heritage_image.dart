import 'package:flutter/material.dart';

ImageProvider<Object> heritageImageProvider(String path) {
  return path.startsWith('assets/') ? AssetImage(path) : NetworkImage(path);
}

Widget heritageImage(
  String path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return Image(
    image: heritageImageProvider(path),
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) => Container(
      width: width,
      height: height,
      color: const Color(0xFFF2E8D5),
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported, color: Color(0xFF9A6A42)),
    ),
  );
}
