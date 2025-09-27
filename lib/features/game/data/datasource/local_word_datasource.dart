import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class LocalWordDatasource {
  final String language; // "en" atau "id"
  LocalWordDatasource({required this.language});

  Future<String> getRandomWord(int length) async {
    // Load file JSON sesuai bahasa
    final filePath = 'assets/words/words_$language.json';
    final data = await rootBundle.loadString(filePath);

    // Decode JSON → Map<String, dynamic>
    final Map<String, dynamic> jsonData = json.decode(data);

    // Ambil list kata sesuai panjang huruf
    final words = List<String>.from(jsonData[length.toString()] ?? []);

    if (words.isEmpty) {
      throw Exception("No words found for length $length in $language");
    }

    // Pilih random word dari list
    final random = Random();
    return words[random.nextInt(words.length)];
  }
}
