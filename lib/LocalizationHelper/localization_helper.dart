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
    dynamic item,
    String? field,
    BuildContext context,
  ) {
    final langCode = context.read<LocaleBloc>().state.langCode;
    if (item is Map<String, dynamic>) {
      return item["${field}_$langCode"] ?? item["${field}_en"] ?? "";
    } else if (item is CartItemModel) {
      return (langCode == "ar" ? item.nameAr : item.nameEn) ?? "";
    }
    return "";
  }


}
