import 'package:word_game/core/failure/failure.dart';
import 'package:word_game/core/model/either.dart';
import 'package:word_game/features/game/data/datasource/local_word_datasource.dart';
import 'package:word_game/features/game/domain/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl();

  @override
  Future<Either<Failure, void>> checkWord(String word) async {
    // Sementara: terima semua kata (return Right(null))
    // Jika nanti ingin validasi, bisa implement cek ke local wordlists
    // atau kembali memakai API untuk memvalidasi kata yang valid.
    return Right(null);
  }

  @override
  Future<Either<Failure, String>> getRandomWord(
    int length, {
    String language = 'en',
  }) async {
    try {
      // buat datasource lokal sesuai bahasa saat runtime
      final localWordDatasource = LocalWordDatasource(language: language);
      final word = await localWordDatasource.getRandomWord(length);
      return Right(word);
    } catch (_) {
      return Left(GameFailure(message: 'Error fetching word'));
    }
  }
}
