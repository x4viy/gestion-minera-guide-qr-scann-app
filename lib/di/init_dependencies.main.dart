part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initUtils();
  _initAuth();
  _initHomePage();
  _initQrScann();
}

void _initUtils() {
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory(() => ApiService());
  serviceLocator.registerFactory(() => AppSecretsService());

  // connection checker impl
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => WebSocketCubit(
        socketUrl: getSocketLoginPath(), appSecretsService: serviceLocator()),
  );
}

void _initHomePage() {
  serviceLocator.registerLazySingleton(
    () => HomePageBloc(),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    // ..registerFactory(
    //   () => UserSignUp(
    //     serviceLocator(),
    //   ),
    // )
    ..registerFactory(
      () => UserLogout(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        // userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userLogout: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initQrScann() {
  serviceLocator.registerLazySingleton(
    () => QrScannBloc(
      webSocketCubit: serviceLocator(),
    ),
  );
}
