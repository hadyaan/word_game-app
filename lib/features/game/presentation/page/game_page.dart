import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/get_it/get_it.dart';
import 'package:word_game/features/game/data/repository/game_repository_impl.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_event.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';
import 'package:word_game/features/game/presentation/widgets/attempts_widget.dart';
import 'package:word_game/features/game/presentation/widgets/game_keyboard.dart';
import 'package:word_game/features/game/presentation/widgets/loss_dialog.dart';
import 'package:word_game/features/game/presentation/widgets/win_dialog.dart';

class GamePage extends StatelessWidget {
  final int attemptsCount;
  final int wordLength;
  final String language;

  const GamePage({
    super.key,
    required this.attemptsCount,
    required this.wordLength,
    required this.language,
  });

  static String route({
    required int wordLength,
    required int attemptsCount,
    required String language,
  }) => Uri(
    path: '/game',
    queryParameters: {
      'attemptsCount': attemptsCount.toString(),
      'wordLength': wordLength.toString(),
      'language': language,
    },
  ).toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GameBloc(gameRepository: GameRepositoryImpl(language: language))..add(
            StartGameEvent(
              attemptsCount: attemptsCount,
              wordLength: wordLength,
              language: language, //  Kirim ke event
            ),
          ),
      child: BlocConsumer<GameBloc, GameState>(
        builder: (context, state) {
          if (state.status == GameStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Game',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                const Expanded(child: AttemptsWidget()),
                // Text('${state.word}'),
                const SizedBox(height: 20),
                GameKeyboard(
                  onKeyPressed: (v) {
                    context.read<GameBloc>().add(EnterKeyEvent(key: v));
                  },
                  onDelete: () {
                    context.read<GameBloc>().add(DeleteKeyEvent());
                  },
                  onSubmit: () {
                    context.read<GameBloc>().add(EnterAttemptEvent());
                  },
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == GameStatus.win) {
            showDialog(
              context: context,
              builder: (context) {
                return WinDialog(word: state.word ?? '');
              },
              barrierDismissible: false,
            );
          } else if (state.status == GameStatus.loss) {
            showDialog(
              context: context,
              builder: (context) {
                return LossDialog(word: state.word ?? '');
              },
              barrierDismissible: false,
            );
          } else if (state.status == GameStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        },
      ),
    );
  }
}
