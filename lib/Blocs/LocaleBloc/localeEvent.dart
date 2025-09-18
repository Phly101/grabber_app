import "dart:ui";
class LocaleEvent{}

class ChangeLang extends LocaleEvent{
  final Locale locale;
  ChangeLang(this.locale);
}