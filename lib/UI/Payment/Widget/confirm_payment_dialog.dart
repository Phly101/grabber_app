import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
//import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
//import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
// import "package:grabber_app/Utils/routes.dart";
import "../../../../l10n/app_localizations.dart";
import "package:grabber_app/Theme/theme.dart";

class PaymentConfirmDialog {
  static Future<void> show({
    required BuildContext context,
    required bool isGiftMode,
    String? receiverEmail,
  }) async {
    final loc = AppLocalizations.of(context)!;
   // final cartBloc = context.read<CartBloc>();
    final giftBloc = context.read<GiftBloc>();
   // final authState = context.read<AuthBloc>().state;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(ctx).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            loc.confirm,
            style: Theme.of(ctx).textTheme.titleLarge,
          ),
          content: Text(
            isGiftMode
                ? "${loc.sendingGiftTo} $receiverEmail"
                : loc.confirm,
            style: Theme.of(ctx).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(loc.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textButtonColor,
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(loc.confirm),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;


    if (isGiftMode) {
      if (receiverEmail != null) {
        Fluttertoast.showToast(
          msg: "${loc.sendingGiftTo} $receiverEmail",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        giftBloc.add(SendGift(receiverEmail));

      } else {
        Fluttertoast.showToast(
          msg: loc.couldntFindTheUser,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

    }

    // if (authState is AuthAuthenticated) {
    //   cartBloc.add(ClearUserCart(authState.user.uid));
    // }

    Fluttertoast.showToast(
      msg: loc.paymentSuccessful,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    //
    // // Still safe to navigate
    // if (context.mounted) {
    //
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     AppRoutes.mainApp,
    //     (route) => false,
    //   );
    // }
  }
}
