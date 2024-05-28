import 'package:assessment/di/repository_module.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../env/env.dart';
import '../network/dio_client.dart';
import 'bloc_module.dart';
import 'db_module.dart';
import 'endpoint_module.dart';

final locator = GetIt.instance;

Future<bool?> getItInit(Env env) async {
  _setupDefaultDio(env.baseUrl,env.token);
  await registerDatabase();
  await registerEndPoints();
  await registerRepositories();
  await registerBlocs();
  print('openning ');
  return null;
}

void _setupDefaultDio(String baseUrl, String token) {
  locator.registerLazySingleton<Dio>(() => DioClient.build(baseUrl, token));
}
