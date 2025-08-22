import 'package:my_users_app/api/api.dart';
import 'package:my_users_app/data/data.dart';
import 'package:my_users_app/domain/repositories/repositories.dart';
import 'package:my_users_app/domain/usecases/usecases.dart';
import 'package:my_users_app/ui/blocs/blocs.dart';
import 'package:my_users_app/ui/cubits/cubits.dart';
import 'package:my_users_app/ui/shared/service/service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class AppDependencyInjection {
  static void init() {
    /// Repositories
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    );

    getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );

    /// Services
    getIt.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );

    ///  Cubits and BLoCs

    // Singleton
    getIt.registerLazySingleton<ThemeModeCubit>(() => ThemeModeCubit());

    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getIt<AuthUseCase>(),
        getIt<KeyValueStorageService>(),
      ),
    );

    getIt.registerLazySingleton<UserBloc>(() => UserBloc());

    // Factory

    getIt.registerFactory<SignInFormCubit>(
      () => SignInFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );

    getIt.registerFactory<RegisterFormCubit>(
      () => RegisterFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );

    getIt.registerFactory<RegisterUserCubit>(() => RegisterUserCubit(
          getIt.get<UserBloc>(),
        ));

    getIt.registerFactory<ManageAddressCubit>(() => ManageAddressCubit(
          getIt.get<UserBloc>(),
        ));
  }
}
