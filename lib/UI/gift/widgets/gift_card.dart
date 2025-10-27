import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/gift/widgets/gift_details_page.dart";

import "../../../l10n/app_localizations.dart";

class GiftCard extends StatelessWidget {
  final GiftModel gift;

  const GiftCard({super.key, required this.gift});

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
        ? "${gift.timestamp!.day}/${gift.timestamp!.month}/${gift.timestamp!.year}"
        : loc.unknownDate;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Theme.of(context).cardTheme.color,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => GiftDetailsPage(gift: gift)),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLightColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.gift,color: AppColors.primaryGreen,),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gift.senderName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      translatedMessage,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        date,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
