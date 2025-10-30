import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Utils/constants.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    sharedPreferences = mockPrefs;
  });

  group("AppThemeBloc Tests", () {
    blocTest<AppThemeBloc, AppThemeState>(
      "emits AppDarkTheme when InitialEvent is added and theme is 'D'",
      build: () {
        when(() => mockPrefs.getString("theme")).thenReturn("D");
        return AppThemeBloc();
      },
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [const AppDarkTheme(appTheme: "D")],
    );

    blocTest<AppThemeBloc, AppThemeState>(
      "emits AppLightTheme when InitialEvent is added and theme is not 'D'",
      build: () {
        when(() => mockPrefs.getString("theme")).thenReturn("L");
        return AppThemeBloc();
      },
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [const AppLightTheme(appTheme: "L")],
    );

    blocTest<AppThemeBloc, AppThemeState>(
      "emits AppLightTheme when LightEvent is added",
      build: () {
        when(() => mockPrefs.setString("theme", "L"))
            .thenAnswer((_) async => true);
        return AppThemeBloc();
      },
      act: (bloc) => bloc.add(LightEvent()),
      expect: () => [const AppLightTheme(appTheme: "L")],
      verify: (_) {
        verify(() => mockPrefs.setString("theme", "L")).called(1);
      },
    );

    blocTest<AppThemeBloc, AppThemeState>(
      "emits AppDarkTheme when DarkEvent is added",
      build: () {
        when(() => mockPrefs.setString("theme", "D"))
            .thenAnswer((_) async => true);
        return AppThemeBloc();
      },
      act: (bloc) => bloc.add(DarkEvent()),
      expect: () => [const AppDarkTheme(appTheme: "D")],
      verify: (_) {
        verify(() => mockPrefs.setString("theme", "D")).called(1);
      },
    );
  });
}
