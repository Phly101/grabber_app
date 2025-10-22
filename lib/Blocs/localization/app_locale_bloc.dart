import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../Utils/constants.dart";
import "app_locale_event.dart";
import "app_locale_state.dart";

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final FirebaseFirestore firestore;

  LocaleBloc(this.firestore) : super(InitialLangState(langCode: "en")) {
    on<InitialLangEvent>(_onInitialLang);
    on<ArabicLangEvent>(_onArabicLang);
    on<EnglishLangEvent>(_onEnglishLang);
  }

  Future<Map<String, String>> _loadTranslations(String langCode) async {
    final snapshot = await firestore.collection("localization").doc(langCode).get();
    return Map<String, String>.from(snapshot.data() ?? {});
  }

  Future<void> _onInitialLang(InitialLangEvent event, Emitter emit) async {
    final saved = sharedPreferences?.getString("lang") ?? "en";
    final translations = await _loadTranslations(saved);
    emit(ChangeLang(langCode: saved, translations: translations));
  }

  Future<void> _onArabicLang(ArabicLangEvent event, Emitter emit) async {
    sharedPreferences?.setString("lang", "ar");
    final translations = await _loadTranslations("ar");
    emit(ChangeLang(langCode: "ar", translations: translations));
  }

  Future<void> _onEnglishLang(EnglishLangEvent event, Emitter emit) async {
    sharedPreferences?.setString("lang", "en");
    final translations = await _loadTranslations("en");
    emit(ChangeLang(langCode: "en", translations: translations));
  }
}