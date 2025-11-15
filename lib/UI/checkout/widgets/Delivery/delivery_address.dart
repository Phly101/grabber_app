import "package:flutter/material.dart";
import "package:grabber_app/UI/checkout/widgets/Delivery/textField_delivaryAddress.dart";
import "package:grabber_app/l10n/app_localizations.dart";


class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(17),
        ),


        TextFieldDeliveryAddress(
          controller: controller2,
          labelText: "First Name",
          hintText: "First Name",
        ),
        const SizedBox(height: 18,),
        TextFieldDeliveryAddress(
          controller: controller2,
          labelText: "Last Name",
          hintText: "Last Name",
        ),
        const SizedBox(height: 18,),
        TextFieldDeliveryAddress(
          controller: controller2,
          labelText: "Address Finder",
          hintText: "Address Finder",
        ),
        const SizedBox(height: 18,),

        TextFieldDeliveryAddress(
          controller: controller2,
          labelText: "Mobile",
          hintText: "Mobile",
        ),

        const SizedBox(
          height: 33,
        ),
        Row(
          children: [
            const Spacer(
              flex: 11,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(AppLocalizations.of(context)!.cancel),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller2.clear();
              },
              child:  Text(AppLocalizations.of(context)!.save),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
