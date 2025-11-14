import 'package:get_it/get_it.dart';
import 'package:sunnova_app/core/db/database_helper.dart';
import 'package:sunnova_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sunnova_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:sunnova_app/features/auth/domain/repositories/user_repository.dart';
import 'package:sunnova_app/features/auth/domain/usecases/get_user_profile.dart';
import 'package:sunnova_app/features/auth/domain/usecases/login_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/logout_user.dart';
import 'package:sunnova_app/features/auth/domain/usecases/register_user.dart';
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';

final sl = GetIt.instance; // sl is short for Service Locator

Future<void> init() async {
  //! Features - Auth
  // Presentation
  sl.registerFactory(
    () => AuthNotifier(
      loginUser: sl(),
      registerUser: sl(),
      logoutUser: sl(),
      getUserProfile: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(databaseHelper: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => DatabaseHelper());

  //! External
  // No external dependencies yet
}
