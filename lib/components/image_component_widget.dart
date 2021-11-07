import 'package:flutter/material.dart';

class ImageComponentWidget extends StatelessWidget {
  final imageUrl;
  ImageComponentWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 250,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
