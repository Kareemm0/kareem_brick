import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<AsyncValue<LanguageState>> {
  final SharedPrefs _localStorage;
  final String defaultLocale;
  LanguageCubit({
    required this.defaultLocale,
    required SharedPrefs localStorage,
  }) : _localStorage = localStorage,
       super(AsyncValue.inititial());

  Future<void> changeLocale(String locale) async {
    switch (state) {
      case AsyncSuccess<LanguageState>(:final value):
        emit(
          AsyncValue.success(ChangeLanguageLoadingState(locale: value.locale)),
        );
        try {
          await _localStorage.setString(LocalKeys.locale, locale);
          emit(
            AsyncValue.success(
              ChangeLanguageSuccessState(locale: value.locale),
            ),
          );
        } catch (e) {
          emit(
            AsyncValue.success(
              ChangeLanguageFailureState(
                locale: value.locale,
                msg: "Something went wrong!",
              ),
            ),
          );
        }

        break;
      default:
    }
  }

  Future<void> getLocale() async {
    emit(AsyncValue.loading());
    try {
      final locale = await _localStorage.getString(LocalKeys.locale);

      locale.fold(
        (failure) {
          emit(AsyncValue.failure("Some Thing Went Wrong "));
        },
        (success) {
          emit(AsyncValue.success(LanguageState(locale: locale.toString())));
        },
      );
      
    } catch (_) {
      emit(AsyncValue.success(LanguageState(locale: defaultLocale)));
    }
  }
}
