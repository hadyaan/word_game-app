import 'package:get_it/get_it.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  registerBloc();
}

// void registerRepositories() {
//   // Daftarkan repository yang sekarang sudah tidak butuh GameRemoteDatasource
//   getIt.registerSingleton<GameRepository>(
//     GameRepositoryImpl(),
//   );
// }

void registerBloc() {
  getIt.registerFactory<GameBloc>(() => GameBloc(gameRepository: getIt()));
}
