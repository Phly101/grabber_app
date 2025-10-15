import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
import "package:grabber_app/UI/gift/gift_card.dart";

class GiftsPage extends StatefulWidget {
  const GiftsPage({super.key});

  @override
  State<GiftsPage> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  @override
  void initState() {
    super.initState();

    // Debug: check if bloc instance is consistent
    final bloc = context.read<GiftBloc>();
    print("GiftBloc hash in initState: ${bloc.hashCode}");

    final currentUserId = bloc.sendGiftService.authProvider.currentUser?.uid;
    if (currentUserId != null) {
      print("Listening to gifts for user: $currentUserId");
      bloc.add(ListenToGifts(currentUserId));
    } else {
      print("⚠️ No current user found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎁 My Gifts"),
        centerTitle: true,
      ),
      body: BlocBuilder<GiftBloc, SendGiftState>(
        buildWhen: (previous, current) {
          print("📦 Rebuilding GiftsPage with state: $current");
          return true; // Always rebuild (for now)
        },
        builder: (context, state) {
          print("GiftBloc hash in builder: ${context.read<GiftBloc>().hashCode}");
          print("🧱 Current state type: ${state.runtimeType}");

          if (state is GiftLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GiftStreamUpdated) {
            final gifts = state.gifts;
            print("🎁 Received ${gifts.length} gifts");

            if (gifts.isEmpty) {
              return const Center(
                child: Text(
                  "No gifts yet 🎀",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: gifts.length,
              itemBuilder: (context, index) {
                final gift = gifts[index];
                print("Gift[$index] -> ${gift.senderName} (${gift.items.length} items)");
                return GiftCard(gift: gift);
              },
            );
          } else if (state is GiftError) {
            print("❌ Error: ${state.message}");
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(
            child: Text(
              "Loading gifts...",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
