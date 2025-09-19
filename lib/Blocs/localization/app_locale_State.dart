abstract class LocaleState {}

class InitialLangState extends LocaleState {}

class ChangeLang extends LocaleState {
  final String langCode;

  ChangeLang({required this.langCode});
}
