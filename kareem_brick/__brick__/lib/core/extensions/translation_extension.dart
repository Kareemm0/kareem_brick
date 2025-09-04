import 'package:flutter/material.dart' show BuildContext;

import '../generated.dart' show AppLang, AppLangAr;

extension TranslationExtension on BuildContext {
  AppLang get tr => AppLang.of(this) ?? AppLangAr();
}
