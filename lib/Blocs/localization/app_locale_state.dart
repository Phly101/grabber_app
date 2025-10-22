abstract class LocaleState {
  final String langCode;
  final Map<String, String> translations;

  LocaleState({required this.langCode, required this.translations});
}

class InitialLangState extends LocaleState {
  InitialLangState({required super.langCode}) : super(translations: {});
}

class ChangeLang extends LocaleState {
  ChangeLang({required super.langCode, required super.translations});
}