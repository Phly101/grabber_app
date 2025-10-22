import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Blocs/localization/app_locale_bloc.dart";
import "package:grabber_app/Blocs/localization/app_locale_event.dart";
import "package:grabber_app/Blocs/localization/app_locale_state.dart";
import "package:grabber_app/Utils/constants.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  group("LocaleBloc with fake_cloud_firestore", () {
    late FakeFirebaseFirestore firestore;
    late LocaleBloc localebloc;

    setUp(() async {
      firestore = FakeFirebaseFirestore();
      localebloc = LocaleBloc(firestore);
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
    });

    tearDown(() async {
      await localebloc.close();
    });

    test("should load default 'en' when no saved lang exists", () async {
      await firestore.collection("localization").doc("en").set({
        "home": "Home",
        "hello": "Hello",
      });
      localebloc.add(InitialLangEvent());

      await expectLater(
        localebloc.stream,
        emits(
          isA<ChangeLang>()
              .having((s) => s.langCode, "langCode", "en")
              .having((s) => s.translations["home"], "home", "Home"),
        ),
      );
    });

    test("should load Arabic translations when ArabicLangEvent added", () async {
      await firestore.collection("localization").doc("ar").set({
        "hello": "مرحبا",
      });

      localebloc.add(ArabicLangEvent());

      await expectLater(
        localebloc.stream,
        emits(
          isA<ChangeLang>()
              .having((s) => s.langCode, "langCode", "ar")
              .having((s) => s.translations["hello"], "hello", "مرحبا"),
        ),
      );
    });

    test("should load saved language from SharedPreferences", () async {
      SharedPreferences.setMockInitialValues({"lang": "ar"});
      final prefs = await SharedPreferences.getInstance();
      sharedPreferences = prefs;

      await firestore.collection("localization").doc("ar").set({
        "hello": "مرحبا",
      });
      localebloc.add(InitialLangEvent());

      await expectLater(
        localebloc.stream,
        emits(
          isA<ChangeLang>()
              .having((s) => s.langCode, "langCode", "ar")
              .having((s) => s.translations["hello"], "hello", "مرحبا"),
        ),
      );
    });

    test(
      "should return empty translations if document not found",
      () async {
        localebloc.add(EnglishLangEvent());

        await expectLater(
          localebloc.stream,
          emits(
            isA<ChangeLang>()
                .having((s) => s.langCode, "langCode", "en")
                .having((s) => s.translations.isEmpty, "translations", true),
          ),
        );
      },
    );
  });
}
