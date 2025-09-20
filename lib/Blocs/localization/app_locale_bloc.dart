import "package:flutter_bloc/flutter_bloc.dart";
import "../../Utils/constants.dart";
import "app_locale_event.dart";
import "app_locale_state.dart";

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(InitialLangState(langCode: "en")) {
    on<LocaleEvent>((event, emit) async {
      if (event is InitialLangEvent) {
        if (sharedPref?.getString("lang") != null) {
          if (sharedPref?.getString("lang") == "ar") {
            emit(ChangeLang(langCode: "ar"));
          }
          else {
            emit(ChangeLang(langCode: "en"));
          }
        }
      }
      else if (event is ArabicLangEvent) {
        sharedPref?.setString("lang", "ar");
        emit(ChangeLang(langCode: "ar"));
      }
      else if (event is EnglishLangEvent) {
      sharedPref?.setString("lang", "en");
      emit(ChangeLang(langCode: "en"));
      }
    });
  }
}
