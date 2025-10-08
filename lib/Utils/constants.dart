import "package:shared_preferences/shared_preferences.dart";

import "../l10n/app_localizations.dart";

SharedPreferences? sharedPreferences;

String mapAuthErrorToMessage(AppLocalizations loc, String? code) {
  switch (code) {
    case "email-already-in-use":
      return loc.emailAlreadyInUse;
    case "invalid-email":
      return loc.invalidEmail;
    case "weak-password":
      return loc.weakPassword;
    case "user-not-found":
      return loc.noUserFoundForThatEmail;
    case "wrong-password":
      return loc.wrongPasswordProvided;
    case "Account not found. Please, sign up.":
      return loc.accountNotFound;
    case "requires-recent-login":
      return loc.pleaseSignInAgainBeforeChangingPassword;
    case "The supplied auth credential is incorrect, malformed or has expired.":
      return "this is zeet";
    default:
      return loc.unknownErrorOccurred;
  }
}
