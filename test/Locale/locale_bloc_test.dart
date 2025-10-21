import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Blocs/localization/app_locale_bloc.dart";
import "package:grabber_app/Blocs/localization/app_locale_event.dart";
import "package:grabber_app/Blocs/localization/app_locale_state.dart";

void main() {
  group("LocaleBloc with fake_cloud_firestore", () {
    final firestore = FakeFirebaseFirestore();
    final localebloc = LocaleBloc(firestore);

    test("InitialLangEvent loads default en when no saved lang", () async {
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

    test("ArabicLangEvent loads Arabic translations", () async {
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

    test("If translation document not found, returns empty translations", () async {
      final firestore2 = FakeFirebaseFirestore();
      final localebloc2 = LocaleBloc(firestore2);
      localebloc2.add(EnglishLangEvent());

      await expectLater(
        localebloc2.stream,
        emits(
          isA<ChangeLang>()
              .having((s) => s.langCode, "langCode", "en")
              .having((s) => s.translations.isEmpty, "translations", true),
        ),
      );
    });

  });
}
