import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'domain/domain.dart';
import 'infrastructure/infrastructure.dart';
import 'presentation/presentation.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectCore();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
  InjectionHelper.injectQueries();
  InjectionHelper.injectCommands();
  InjectionHelper.injectUsecases();
  InjectionHelper.injectBlocs();
}

abstract class InjectionHelper {
  static Future<void> injectExternal() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerFactory<BaseLocalStorage>(
      () => SharedPrefsLocalStorageImpl(preferences: sharedPreferences),
    );
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<AppInterceptors>(
        AppInterceptors(sharedPrefs: getIt()));

    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(
        baseUrl: EndPoints.baseUrl,
        client: getIt(),
        interceptors: [getIt<AppInterceptors>()],
      ),
    );
  }

  static void injectCore() {}

  static void injectDatasources() {
    getIt.registerFactory<AuthDatasource>(() => AuthDatasourceImpl(
          apiConsumer: getIt(),
        ));
  }

  static void injectRepos() {
    getIt.registerFactory<AuthRepo>(() => AuthRepoImpl(datasource: getIt()));
  }

  static void injectCommands() {}

  static void injectQueries() {}

  static void injectUsecases() {}

  static void injectBlocs() {
    getIt.registerFactory<AuthBloc>(() => AuthBloc(
          repo: getIt(),
          localStorage: getIt(),
        ));
    getIt.registerFactory<LanguageCubit>(() => LanguageCubit(
          localStorage: getIt(),
          defaultLocale: AppConstants.defaultLangCode,
        ));
  }
}
