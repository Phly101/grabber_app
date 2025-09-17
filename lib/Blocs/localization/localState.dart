import "dart:ui";

class LocaleState{}

class LocalInitial extends LocaleState{
  final Locale locale;
  LocalInitial(this.locale);
}

class LocaleUpdated extends LocaleState{
  final Locale locale;
  LocaleUpdated(this.locale);
}