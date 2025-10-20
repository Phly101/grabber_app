import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../Blocs/localization/app_locale_bloc.dart";
import "../Blocs/CartBloc/cart_item_model.dart";

class LocalizationHelper {

  static String getString(BuildContext context, String key) {
    final state = context.read<LocaleBloc>().state;
    return state.translations[key] ?? key;
  }


  static String localizedProductField(
      Map<String, dynamic> item,
      String? field,
      BuildContext context,
      ) {
    final langCode = context.read<LocaleBloc>().state.langCode;
    return item["${field}_$langCode"] ?? item["${field}_en"] ?? "";
  }


  static String localizedItemName(dynamic item, BuildContext context) {
    final langCode = context.read<LocaleBloc>().state.langCode;

    if (item is CartItemModel) {

      return (langCode == "ar" ? item.nameAr : item.nameEn) ?? "";
    } else if (item is Map<String, dynamic>) {

      return langCode == "ar"
          ? (item["title_ar"] ?? item["title_en"] ?? "")
          : (item["title_en"] ?? item["title_ar"] ?? "");
    }
    return "";
  }
}
