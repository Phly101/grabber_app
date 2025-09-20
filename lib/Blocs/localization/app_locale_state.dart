abstract class LocaleState {
  final String langCode;
  LocaleState({required this.langCode});
}

class InitialLangState extends LocaleState {
  InitialLangState({required super.langCode});
}

class ChangeLang extends LocaleState {
  @override
  final String langCode;

  ChangeLang({required this.langCode}) : super(langCode: "");
}
