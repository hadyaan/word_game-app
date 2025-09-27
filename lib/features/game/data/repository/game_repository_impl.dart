import 'package:word_game/core/failure/failure.dart';
import 'package:word_game/core/model/either.dart';
import 'package:word_game/features/game/data/datasource/local_word_datasource.dart';
import 'package:word_game/features/game/domain/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final String language; // simpan bahasa pilihan

  GameRepositoryImpl({required this.language});

  @override
  Future<Either<Failure, void>> checkWord(String word) async {
    try {
      final localWordDatasource = LocalWordDatasource(language: language);
      final isValid = await localWordDatasource.checkWord(word);

      if (isValid) {
        return Right(null); // Kata valid
      } else {
        return Left(GameFailure(message: 'Please enter the correct word'));
      }
    } catch (_) {
      return Left(GameFailure(message: 'Error validating word'));
    }
  }

  @override
  Future<Either<Failure, String>> getRandomWord(
    int length, {
    String language = 'en',
  }) async {
    try {
      final localWordDatasource = LocalWordDatasource(language: language);
      final word = await localWordDatasource.getRandomWord(length);
      return Right(word);
    } catch (_) {
      return Left(GameFailure(message: 'Error fetching word'));
    }
  }
}
