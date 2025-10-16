import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/gift/widgets/build_info_tile.dart";
import "package:grabber_app/UI/gift/widgets/content_of_details_page.dart";

class GiftDetailsPage extends StatelessWidget {
  final GiftModel gift;

  const GiftDetailsPage({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    final date = gift.timestamp != null
        ? "${gift.timestamp!.day}/${gift.timestamp!.month}/${gift.timestamp!.year} ${gift.timestamp!.hour}:${gift.timestamp!.minute.toString().padLeft(2, '0')}"
        : "Unknown time";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gift Details",
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
                child: const Icon(
                  Icons.card_giftcard,
                  size: 60,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 30),
            BuildInfoTile(context: context, icon: Icons.person_outline, label: "From", value: gift.senderName),
            BuildInfoTile(context: context, icon: Icons.email_outlined, label: "Email", value: gift.senderEmail),
            BuildInfoTile(context: context, icon: Icons.message_outlined, label: "Message", value: gift.message),
            BuildInfoTile(context: context, icon: Icons.calendar_today_outlined, label: "Received on", value: date),
            const Divider(height: 40, thickness: 1),
            Text(
              "Gift Items:",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 15),
            if (gift.items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "No items in this gift.",
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
                  final String itemName = item["nameEn"] ?? "Unnamed item";
                  final int itemQuantity = item["quantity"] ?? 1;
                  final String itemPrice = item["price"].toString();

                  return ContentOfDetailsPage(imageUrl: imageUrl, itemName: itemName, itemQuantity: itemQuantity, itemPrice: itemPrice);
                },
              ),
          ],
        ),
      ),
    );
  }
}
