import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
import "package:grabber_app/UI/gift/widgets/gift_card.dart";
import "package:grabber_app/l10n/app_localizations.dart";

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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.myGifts,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
      ),
      body: BlocBuilder<GiftBloc, SendGiftState>(
        builder: (context, state) {
          if (state is GiftLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GiftStreamUpdated) {
            final gifts = state.gifts;

            if (gifts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.gift),
                    const SizedBox(height: 20),
                    Text(
                      loc.noGiftsYet,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.startSharingGifts,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: gifts.length,
                  itemBuilder: (context, index) {
                    final gift = gifts[index];
                    return GiftCard(gift: gift);
                  },
                ),
                Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BlocListener<GiftBloc, SendGiftState>(
                      listener: (context, state) {
                        if (state is DeleteGiftsAndNotifSuccess) {
                          Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!.allGiftsDeleted,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFF4CAF50),
                            // green success
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else if (state is SendGiftFailure) {
                          Fluttertoast.showToast(
                            msg: state.message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFFF44336),
                            // red error
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          final currentUserId = context
                              .read<GiftBloc>()
                              .sendGiftService
                              .authProvider
                              .currentUser
                              ?.uid;
                          context.read<GiftBloc>().add(
                            DeleteAllGiftsAndNotif(currentUserId!),
                          );
                        },
                        child: Card(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.tapToClearNotifications,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.trash,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is GiftError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loc.errorLoadingGifts,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  loc.preparingYourGifts,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
