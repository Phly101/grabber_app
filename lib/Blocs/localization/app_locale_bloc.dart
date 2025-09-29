import "package:flutter_bloc/flutter_bloc.dart";
import "../../Utils/constants.dart";
import "app_locale_event.dart";
import "app_locale_state.dart";

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(InitialLangState(langCode: "en")) {
    on<LocaleEvent>((event, emit) async {
      if (event is InitialLangEvent) {
        if (sharedPreferences?.getString("lang") != null) {
          if (sharedPreferences?.getString("lang") == "ar") {
            emit(ChangeLang(langCode: "ar"));
          }
          else {
            emit(ChangeLang(langCode: "en"));
          }
        }
      }
      else if (event is ArabicLangEvent) {
        sharedPreferences?.setString("lang", "ar");
        emit(ChangeLang(langCode: "ar"));
      }
      else if (event is EnglishLangEvent) {
      sharedPreferences?.setString("lang", "en");
      emit(ChangeLang(langCode: "en"));
      }
    });
  }
}
