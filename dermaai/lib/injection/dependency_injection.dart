import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../core/network/api_client.dart';
import '../features/analysis/data/repositories/analysis_repository_impl.dart';
import '../features/analysis/domain/repositories/analysis_repository.dart';
import '../features/analysis/presentation/bloc/analysis_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core Utility Engines
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  // Architectural Repositories Setup
  sl.registerLazySingleton<AnalysisRepository>(() => AnalysisRepositoryImpl(sl<ApiClient>()));

  // State Control Layer Instances
  sl.registerFactory<AnalysisBloc>(() => AnalysisBloc(sl<AnalysisRepository>()));
}