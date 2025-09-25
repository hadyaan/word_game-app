import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';

class GameKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onDelete;
  final Function() onSubmit;
  const GameKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onDelete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    const rows = ['QWERTYUIOP', 'ASDFGHJKL', 'ZXCVBNM'];
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...rows.map((row) => _buildKeyboardRow(context, state, row)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyboardRow(BuildContext context, GameState state, String row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row
          .split('')
          .map((key) => _buildKey(context, state, key))
          .toList(),
    );
  }

  Widget _buildKey(BuildContext context, GameState state, String key) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: ElevatedButton(
            onPressed: () => onKeyPressed(key),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              key,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
