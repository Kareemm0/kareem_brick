part of 'language_cubit.dart';

final class LanguageState extends Equatable {
  final String locale;

  const LanguageState({required this.locale});

  @override
  List<Object?> get props => [locale];
}

final class ChangeLanguageLoadingState extends LanguageState {
  const ChangeLanguageLoadingState({required super.locale});
}

final class ChangeLanguageFailureState extends LanguageState {
  final String msg;
  const ChangeLanguageFailureState({
    required super.locale,
    required this.msg,
  });
}

final class ChangeLanguageSuccessState extends LanguageState {
  const ChangeLanguageSuccessState({required super.locale});
}
