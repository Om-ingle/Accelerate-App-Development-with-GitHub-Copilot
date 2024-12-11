
import 'package:flutter/material.dart';

class GameProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 6,
            backgroundColor: Colors.grey,
          ),
        );
      }),
    );
  }
}