import 'package:flutter/material.dart';
import 'solved_group_tile.dart';
import '../models/game_model.dart';

class GameGrid extends StatelessWidget {
  final Game game;
  final List<String> words;
  final Set<String> selectedTiles;
  final List<Set<String>> solvedGroups;
  final Function(String) onTileSelected;

  const GameGrid({
    Key? key,
    required this.game,
    required this.words,
    required this.selectedTiles,
    required this.solvedGroups,
    required this.onTileSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solvedWords = solvedGroups.expand((group) => group).toSet();
    final availableWords = words.where((word) => !solvedWords.contains(word)).toList();

    return Column(
      children: [
        // Display solved groups in a grid
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: solvedGroups.map((group) => SolvedGroupTile(
            words: group,
            metadata: game.getGroupMetadata(group)!,
          )).toList(),
        ),
        
        // Display available words
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: availableWords.length,
          itemBuilder: (context, index) {
            final word = availableWords[index];
            final isSelected = selectedTiles.contains(word);
            return _buildTile(word, isSelected);
          },
        ),
      ],
    );
  }

  // Update tile appearance
  Widget _buildTile(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => onTileSelected(text),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ] : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue[900] : Colors.black87,
          ),
        ),
      ),
    );
  }
}