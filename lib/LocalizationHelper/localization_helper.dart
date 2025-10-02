import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../Blocs/localization/app_locale_bloc.dart";

class LocalizationHelper {

  static String getString(BuildContext context, String key) {
    final state = context.read<LocaleBloc>().state;
    return state.translations[key] ?? key; // fallback to key if missing
  }
  static String localizedProductField(
      Map<String, dynamic> item,
      String field,
      BuildContext context,
      ) {
    final langCode = context.read<LocaleBloc>().state.langCode;


    // Option B: if product fields are flat
    // { "name_en": "Apple", "name_ar": "تفاحة" }
    return item["${field}_$langCode"] ?? item["${field}_en"] ?? "";
  }

}