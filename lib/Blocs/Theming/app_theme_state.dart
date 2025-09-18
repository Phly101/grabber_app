part of "app_theme_bloc.dart";

sealed class AppThemeState {
  final String? appTheme;

  const AppThemeState({this.appTheme});
}

final class AppThemeInitial extends AppThemeState {
  const AppThemeInitial() : super(appTheme: null);
}

final class AppLightTheme extends AppThemeState {
  const AppLightTheme({required String appTheme}) : super(appTheme: appTheme);
}

final class AppDarkTheme extends AppThemeState {
  const AppDarkTheme({required String appTheme}) : super(appTheme: appTheme);
}
