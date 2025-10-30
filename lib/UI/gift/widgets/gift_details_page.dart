import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/gift/widgets/build_info_tile.dart";
import "package:grabber_app/UI/gift/widgets/content_of_details_page.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class GiftDetailsPage extends StatelessWidget {
  final GiftModel gift;

  const GiftDetailsPage({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    String translatedMessage;
    if (gift.message == "enjoyYourGift") {
      translatedMessage = loc.enjoyYourGift;
    } else {
      translatedMessage = gift.message;
    }
    final date = gift.timestamp != null
        ? "${gift.timestamp!.day}/${gift.timestamp!.month}/${gift.timestamp!.year} ${gift.timestamp!.hour}:${gift.timestamp!.minute.toString().padLeft(2, '0')}"
        : loc.unknownTime;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.giftDetails,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLightColor,
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.gift,
                  color: AppColors.primaryGreen,
                  size: 55,
                ),
              ),
            ),
            const SizedBox(height: 30),
            BuildInfoTile(
              context: context,
              icon: Icons.person_outline,
              label: loc.from,
              value: gift.senderName,
            ),
            BuildInfoTile(
              context: context,
              icon: Icons.email_outlined,
              label: loc.email,
              value: gift.senderEmail,
            ),
            BuildInfoTile(
              context: context,
              icon: Icons.message_outlined,
              label: loc.message,
              value: translatedMessage,
            ),
            BuildInfoTile(
              context: context,
              icon: Icons.calendar_today_outlined,
              label: loc.receivedOn,
              value: date,
            ),
            const Divider(height: 40, thickness: 1),
            Text(
              loc.giftItems,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 15),
            if (gift.items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  loc.noItemsInGift,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gift.items.length,
                itemBuilder: (context, index) {
                  final item = gift.items[index];
                  final String? imageUrl = item["imagePath"];
                  final langCode = Localizations.localeOf(context).languageCode;
                  final String itemName = langCode == "ar"
                      ? (item["nameAr"] ?? item["nameEn"] ?? "بدون اسم")
                      : (item["nameEn"] ?? item["nameAr"] ?? "Unnamed item");
                  final int itemQuantity = item["quantity"] ?? 1;
                  final String itemPrice = item["price"].toString();

                  return ContentOfDetailsPage(
                    imageUrl: imageUrl,
                    itemName: itemName,
                    itemQuantity: itemQuantity,
                    itemPrice: itemPrice,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
