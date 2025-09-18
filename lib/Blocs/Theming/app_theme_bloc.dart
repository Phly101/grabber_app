import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Utils/constants.dart";

part "app_theme_event.dart";

part "app_theme_state.dart";

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeInitial()) {

    on<InitialEvent>((event, emit) {
      final theme = sharedPreferences?.getString("theme");
      if (theme == "D") {
        emit(const AppDarkTheme(appTheme: "D"));
      } else {
        emit(const AppLightTheme(appTheme: "L"));
      }
    });

    on<LightEvent>((event, emit) {
      sharedPreferences?.setString("theme", "L");
      emit(const AppLightTheme(appTheme: "L"));
    });

    on<DarkEvent>((event, emit) {
      sharedPreferences?.setString("theme", "D");
      emit(const AppDarkTheme(appTheme: "D"));
    });
  }
}
