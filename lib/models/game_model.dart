import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Game {
  final String id;
  final List<String> words;
  final List<List<String>> solutions;
  final List<GroupMetadata> groupsMetadata;

  Game({
    required this.id,
    required this.words,
    required this.solutions,
    required this.groupsMetadata,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      words: List<String>.from(json['words']),
      solutions: List<List<String>>.from(
        json['solutions'].map((x) => List<String>.from(x)),
      ),
      groupsMetadata: List<GroupMetadata>.from(
        json['groupsMetadata'].map((x) => GroupMetadata.fromJson(x)),
      ),
    );
  }

  GroupMetadata? getGroupMetadata(Set<String> selectedWords) {
    // Check each solution group
    for (int i = 0; i < solutions.length; i++) {
      Set<String> solutionSet = solutions[i].toSet();
      if (SetEquality().equals(selectedWords, solutionSet)) {
        return groupsMetadata[i];
      }
    }
    return null;
  }
}

class GroupMetadata {
  final Color color;
  final String hint;

  GroupMetadata({required this.color, required this.hint});

  factory GroupMetadata.fromJson(Map<String, dynamic> json) {
    return GroupMetadata(
      color: Color(int.parse(json['color'], radix: 16)),
      hint: json['hint'],
    );
  }
}