import '../drift/app_database.dart';
import '../drift/config/native.dart';
import 'service_locator.dart';

Future<void> registerDatabase() async {
  // locator.registerSingleton<AppDatabase>(db);
  //dao
  final db = constructDb();
  locator.registerLazySingleton<AppDatabase>(() => db);
  locator.registerLazySingleton(() => locator.get<AppDatabase>().cartDao);
}
