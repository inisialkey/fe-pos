import 'package:get_it/get_it.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }

  if (isHiveEnable) {
    await _initHiveBoxes(isUnitTest: isUnitTest, prefixBox: prefixBox);
  }
  sl.registerSingleton<DioClient>(DioClient(isUnitTest: isUnitTest));
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

Future<void> _initHiveBoxes({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainBoxMixin.initHive(prefixBox);
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<UsersRemoteDatasource>(
    () => UsersRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(sl()),
  );
}

void _useCase() {
  /// Auth
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostLogout(sl()));
  sl.registerLazySingleton(() => PostGeneralToken(sl()));

  /// Users
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));

  /// Products
  sl.registerLazySingleton(() => GetLocalProduct(sl()));
  sl.registerLazySingleton(() => SyncProduct(sl()));
}

void _cubit() {
  /// Auth
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => GeneralTokenCubit(sl()));
  sl.registerFactory(() => LogoutCubit(sl()));

  /// General
  sl.registerFactory(() => ReloadFormCubit());

  /// Users
  sl.registerFactory(() => UserCubit(sl()));
  sl.registerFactory(() => UsersCubit(sl()));
  sl.registerFactory(() => SettingsCubit());

  // Home
  sl.registerFactory(() => GetLocalProductCubit(sl()));

  /// Configuration
  sl.registerFactory(() => SyncProductCubit(sl()));
}
