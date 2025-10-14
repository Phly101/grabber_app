

import "package:flutter/material.dart";
import "package:grabber_app/Services/sendGift/Models/gift_model.dart";

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
        title: const Text("Gift Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(Icons.card_giftcard,
                    
                    ),
              ),
              const SizedBox(height: 20),
              _buildInfo("From", gift.senderName),
              _buildInfo("Email", gift.senderEmail),
              _buildInfo("Message", gift.message),
              _buildInfo("Received on", date),
              const Divider(height: 30),
              const Text(
                "Gift Items:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (gift.items.isEmpty)
                const Text("No items in this gift.")
              else
                Column(
                  children: gift.items.map((item) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined),
                        title: Text(item["name"] ?? "Unnamed item"),
                        subtitle: Text(
                          "Qty: ${item["quantity"] ?? 1}  •  Price: ${item["price"] ?? "N/A"}",
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
