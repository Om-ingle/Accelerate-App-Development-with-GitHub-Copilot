import 'package:flutter/material.dart';
import '../models/game_model.dart';

class SolvedGroupTile extends StatelessWidget {
  final Set<String> words;
  final GroupMetadata metadata;

  const SolvedGroupTile({
    Key? key,
    required this.words,
    required this.metadata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: metadata.color, width: 2),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: metadata.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              metadata.hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: metadata.color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              words.join('\n'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.3,
                color: metadata.color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}