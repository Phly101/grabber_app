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

    final bloc = context.read<GiftBloc>();
    final currentUserId = bloc.sendGiftService.authProvider.currentUser?.uid;

    if (currentUserId != null) {
      bloc.add(ListenToGifts(currentUserId));
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
        builder: (context, state) {
          if (state is GiftLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GiftStreamUpdated) {
            final gifts = state.gifts;

            if (gifts.isEmpty) {
              return const Center(
                child: Text(
                  "No gifts yet ",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: gifts.length,
              itemBuilder: (context, index) {
                return GiftCard(gift: gifts[index]);
              },
            );
          } else if (state is GiftError) {
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
