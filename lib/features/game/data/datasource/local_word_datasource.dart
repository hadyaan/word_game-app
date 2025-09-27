import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class LocalWordDatasource {
  final String language; // "en" atau "id"
  LocalWordDatasource({required this.language});

  Future<String> getRandomWord(int length) async {
    final filePath = 'assets/words/words_$language.json';
    final data = await rootBundle.loadString(filePath);
    final Map<String, dynamic> jsonData = json.decode(data);

    final words = List<String>.from(jsonData[length.toString()] ?? []);

    if (words.isEmpty) {
      throw Exception("No words found for length $length in $language");
    }

    final random = Random();
    return words[random.nextInt(words.length)];
  }

  /// Fungsi untuk cek apakah kata valid di wordlist JSON
  Future<bool> checkWord(String word) async {
    final filePath = 'assets/words/words_$language.json';
    final data = await rootBundle.loadString(filePath);
    final Map<String, dynamic> jsonData = json.decode(data);

    // Ambil semua list kata dari seluruh panjang kata
    final allWords = jsonData.values
        .expand((e) => List<String>.from(e))
        .toList();

    return allWords.contains(word.toLowerCase());
  }
}
