import 'package:get_it/get_it.dart';
import 'package:telemedicina_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:telemedicina_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:telemedicina_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:telemedicina_app/features/authentication/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;
Future<void> initInjector() async {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => FakeAuthRemoteDataSource(),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    );
}
