import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_game/features/game/presentation/page/game_page.dart';
import 'package:word_game/features/home/presentation/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: HomePage.route,
    routes: [
      GoRoute(
        path: HomePage.route,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/game',
        builder: (context, state) {
          // Ambil parameter dari query
          final attemptsCount = int.tryParse(
                state.uri.queryParameters['attemptsCount'] ?? '',
              ) ??
              5; // default 5 percobaan
          final wordLength = int.tryParse(
                state.uri.queryParameters['wordLength'] ?? '',
              ) ??
              5; // default panjang kata 5
          final language = state.uri.queryParameters['language'] ?? 'en';

          return GamePage(
            attemptsCount: attemptsCount,
            wordLength: wordLength,
            language: language,
          );
        },
      ),
    ],
  );
}
