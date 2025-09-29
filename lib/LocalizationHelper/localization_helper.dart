import "package:flutter/cupertino.dart";
import "../../l10n/app_localizations.dart";

class LocalizationHelper {
  static final Map<String, String Function(AppLocalizations)> _localizationMap = {
    "fruits": (l) => l.fruits,
    "vegetables": (l) => l.vegetables,
    "beverages": (l) => l.beverages,
    "milkAndEgg": (l) => l.milkAndEgg,
    "Biscuit": (l) => l.biscuit,
    "Detergent": (l) => l.detergent,
    "laundry": (l) => l.laundry,
    "banana": (l) => l.banana,
    "apple": (l) => l.apple,
    "strawberry": (l) => l.strawberry,
    "lemon": (l) => l.lemon,
    "waterMelon": (l) => l.waterMelon,
    "orange": (l) => l.orange,
    "pepper": (l) => l.pepper,
    "offer30": (l) => l.offer30,
    "enjoyOurBigOffer": (l) => l.enjoyOurBigOffer,
    "offer25": (l) => l.offer25,
    "getSameDayDeliver": (l) => l.getSameDayDeliver,
    "payWithCard": (l) => l.payWithCard,
    "bananaBundle300g": (l) => l.bananaBundle300g,
    "oranges500g": (l) => l.oranges500g,
    "purex250ml": (l) => l.purex250ml,
    "lemons1kg": (l) => l.lemons1kg,
    "quadratiniBiscuit": (l) => l.quadratiniBiscuit,
    "bellPeppers400g": (l) => l.bellPeppers400g,
    "grapes": (l) => l.grapes,
    "pineapple": (l) => l.pineapple,
    "time0800to0930": (l) => l.time0800to0930,
    "time1000to1115": (l) => l.time1000to1115,
    "time1230to0145v": (l) => l.time1230to0145v,
    "time0300to0415": (l) => l.time0300to0415,
    "time0530to0645": (l) => l.time0530to0645,
    "time0800to0915": (l) => l.time0800to0915,
    "time0630to0700": (l) => l.time0630to0700,
    "free": (l) => l.free,
    "price1": (l) => l.price1,
    "price2": (l) => l.price2,
    "rating1": (l) => l.rating1,
    "rating48With287": (l) => l.rating48With287,
    "Biscuit": (l) => l.biscuit,
    "Detergent": (l) => l.detergent,
  };

  static String getString(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    return _localizationMap[key]?.call(localizations) ?? key;
  }
}