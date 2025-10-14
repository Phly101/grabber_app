import "package:flutter/material.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";
import "package:grabber_app/UI/gift/gift_details_page.dart";

class GiftCard extends StatelessWidget {
  final GiftModel gift;

  const GiftCard({required this.gift});

  @override
  Widget build(BuildContext context) {
    final date = gift.timestamp != null
        ? "${gift.timestamp!.day}/${gift.timestamp!.month}/${gift.timestamp!.year}"
        : "Unknown date";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GiftDetailsPage(gift: gift)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                
                child: Icon(Icons.card_giftcard, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gift.senderName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gift.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
