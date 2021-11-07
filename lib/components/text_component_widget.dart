import 'package:flutter/material.dart';

class TextComponentWidget extends StatelessWidget {
  final String title;
  final String description;

  const TextComponentWidget({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      color: Colors.pinkAccent.shade100.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
