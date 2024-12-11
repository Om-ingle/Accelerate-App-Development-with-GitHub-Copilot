import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';  // Add this import
import 'models/game_model.dart';
import 'components/game_header.dart';
import 'components/game_grid.dart';
import 'components/game_controls.dart';
import 'components/progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYT Games Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Set<String> selectedTiles = {};
  Game? currentGame;
  List<Set<String>> solvedGroups = [];

  @override
  void initState() {
    super.initState();
    _loadGame();
  }

  Future<void> _loadGame() async {
    final String jsonString = await rootBundle.loadString('assets/games.json');
    final json = jsonDecode(jsonString);
    setState(() {
      currentGame = Game.fromJson(json['games'][0]);
    });
  }

  void toggleSelection(String text) {
    setState(() {
      if (selectedTiles.contains(text)) {
        selectedTiles.remove(text);
      } else if (selectedTiles.length < 4) {
        selectedTiles.add(text);
      }
    });
  }

  void _handleSubmit() {
    if (selectedTiles.length != 4 || currentGame == null) {
      print('Invalid submission: ${selectedTiles.length} tiles selected');
      return;
    }

    print('Selected tiles: ${selectedTiles.toString()}');
    print('Available solutions: ${currentGame!.solutions.toString()}');

    final metadata = currentGame!.getGroupMetadata(selectedTiles);
    if (metadata != null) {
      print('Found matching group: ${metadata.hint}');
      setState(() {
        solvedGroups.add(HashSet.from(selectedTiles));
        selectedTiles.clear();
      });
    } else {
      print('No matching group found');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Try again! These words don\'t form a group.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentGame == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GameHeader(),
            GameGrid(
              game: currentGame!,
              words: currentGame!.words,
              selectedTiles: selectedTiles,
              solvedGroups: solvedGroups,
              onTileSelected: toggleSelection,
            ),
            GameControls(
              onShuffle: () {},
              onDeselectAll: () => setState(() => selectedTiles.clear()),
              onSubmit: _handleSubmit,
            ),
            SizedBox(height: 8),
            GameProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
