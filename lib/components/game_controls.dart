
import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onShuffle;
  final VoidCallback onDeselectAll;
  final VoidCallback onSubmit;

  const GameControls({
    required this.onShuffle,
    required this.onDeselectAll,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onShuffle,
            child: Text('Shuffle'),
          ),
          TextButton(
            onPressed: onDeselectAll,
            child: Text('Deselect All'),
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}