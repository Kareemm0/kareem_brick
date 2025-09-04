import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider, BlocBuilder;

import 'app/app.dart';
import 'core/core.dart';
import 'injection_container.dart' show getIt;
import 'presentation/presentation.dart'
    show AuthBloc, LanguageCubit, LanguageState;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LanguageCubit>()..getLocale(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, AsyncValue<LanguageState>>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: switch (state) {
              AsyncSuccess(:final value) => Locale(value.locale),
              _ => const Locale(AppConstants.defaultLangCode),
            },
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLang.localizationsDelegates,
            supportedLocales: AppLang.supportedLocales,
            routerConfig: appRouter,
            builder: (context, child) {
              return Theme(
                data: appTheme(),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
