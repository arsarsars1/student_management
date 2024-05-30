import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:studet_managment/models/batch.dart';

import '../repositories/auth_repository.dart';
import '../repositories/batch_repository.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BatchAdapter());
  await Hive.openBox<Batch>('batches');
  await Hive.openBox('userBox');

  final batchBox = Hive.box<Batch>('batches');
  getIt.registerSingleton(batchBox);

  final userBox = Hive.box('userBox');
  getIt.registerSingleton(userBox);

  getIt.registerLazySingleton(() => AuthRepository(userBox));
  getIt.registerLazySingleton(() => BatchRepository(batchBox));
}
