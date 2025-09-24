import "package:flutter/material.dart";
import "../../../l10n/app_localizations.dart";
import "key_value_tile.dart";
import "optionTile.dart";

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Text(
            AppLocalizations.of(context)!.delivery,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        OptionTile(
          onTap:  () {},
          child: ListTile(
            leading: Image.asset("Assets/Icons/home-address 1.png"),
            title: Text(
              AppLocalizations.of(context)!.deliveryAddress,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/gps-svgrepo-com 3.png"),
            label: AppLocalizations.of(context)!.deliverToCurrentLocation,
            icon: Icons.gps_fixed,
            colorIcon: Colors.red,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Text(
            AppLocalizations.of(context)!.paymentMethod,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),

        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/visa.png"),
            label: "xxxx xxxx xxxx xxxx",
            icon: Icons.chevron_right,
          ),
        ),

        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/master.png"),
            label: "xxxx xxxx xxxx xxxx",
            icon: Icons.chevron_right,
          ),
        ),

        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/upi.png"),
            label: AppLocalizations.of(context)!.upiPay,
            icon: Icons.chevron_right,
          ),
        ),

        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/Group 46.png"),
            label: AppLocalizations.of(context)!.scanAndPay,
            icon: Icons.chevron_right,
          ),
        ),
         ListTile(
          leading: Text(
            AppLocalizations.of(context)!.other,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        OptionTile(
          onTap:  () {},
          child: KeyValueTile.icon(
            leading: Image.asset("Assets/Icons/money.png"),
            label: AppLocalizations.of(context)!.cashOnDelivery,
            icon: Icons.chevron_right,
          ),
        ),
      ],
    );
  }
}
