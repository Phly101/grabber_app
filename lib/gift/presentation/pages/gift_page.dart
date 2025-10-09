import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/gift/models/gift_item_model.dart";
import "../widgets/gift_item_widget.dart";

/// Gift Page: Displays list of gifts and a take gift button
class GiftPage extends StatefulWidget {
  const GiftPage({super.key});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  // Sample static data (replace later with backend data)
  final List<GiftItemModel> gifts = [
    GiftItemModel(
      gift: "Mango Juice",
      sender: "Ahmed",
      quantity: 2,
      image:
          "https://static.vecteezy.com/system/resources/previews/038/935/362/original/ai-generated-glass-of-mango-juice-fresh-mango-smoothie-fresh-tropical-mango-juice-mango-juice-transparent-background-png.png",
    ),
    GiftItemModel(
      gift: "Pomegranate Juice",
      sender: "Mona",
      quantity: 1,
      image:
          "https://thumbs.dreamstime.com/b/striking-image-capturing-dynamic-splash-pomegranate-drink-set-against-dramatic-backdrop-whole-fruits-ai-refreshing-304368756.jpg",
    ),
    GiftItemModel(
      gift: "Cola",
      sender: "Omar",
      quantity: 3,
      image:
          "https://static.vecteezy.com/system/resources/previews/047/429/595/non_2x/refreshing-glass-of-cola-with-ice-cubes-splashing-out-perfect-for-representing-a-cool-beverage-or-drink-advertisement-png.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.mainApp);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          "Gifts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          FaIcon(FontAwesomeIcons.gift),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gifts.length,
              itemBuilder: (context, index) {
                final gift = gifts[index];
                return GiftItem(item: gift);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        ),
        icon: const FaIcon(FontAwesomeIcons.handHoldingHeart, color: Colors.white),
        label: const Text(
          "Take Gift",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text("Taking your gift...")),
          // );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
