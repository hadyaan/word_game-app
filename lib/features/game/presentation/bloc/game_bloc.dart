import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/game/presentation/bloc/game_event.dart';
import 'package:word_game/features/game/presentation/bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<StartGameEvent>(onStartGameEvent);
    on<EnterKeyEvent>(onEnterKeyEvent);
    on<DeleteKeyEvent>(onDeleteKeyEvent);
  }

  Future onStartGameEvent(StartGameEvent event, Emitter<GameState> emit) async {
    emit(
      state.copyWith(
        status: GameStatus.inProgress,
        word: 'TEST',
        attemptsCount: event.attemptsCount,
      ),
    );
  }

  Future onEnterKeyEvent(EnterKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempt = state.currentAttempt ?? '';
    var word = state.word ?? '';

    if (word.isEmpty) {
      return;
    }
    if (currentAttempt.length >= word.length) {
      return;
    }

    emit(
      state.copyWith(
        currentAttempt: currentAttempt + event.key,
        status: GameStatus.inProgress,
      ),
    );
  }

  Future onDeleteKeyEvent(DeleteKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempt = state.currentAttempt ?? '';
    if (currentAttempt.isEmpty) {
      return;
    }
    emit(
      state.copyWith(
        status: GameStatus.inProgress,
        currentAttempt: currentAttempt.substring(0, currentAttempt.length - 1),
      ),
    );
  }
}
