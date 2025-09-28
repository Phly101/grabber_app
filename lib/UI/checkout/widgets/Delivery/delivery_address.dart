import "package:flutter/material.dart";
import "package:grabber_app/UI/checkout/widgets/Delivery/textField_delivaryAddress.dart";
import "../../../../Theme/theme.dart";

class DeliveryAddress extends StatelessWidget {
  DeliveryAddress({super.key});

  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(17),
        ),

        TextfieldDelivaryaddress(
          controller: controller2,
          labelText: "First Name",
          hintText: "First Name",
        ),
        const SizedBox(height: 18,),
        TextfieldDelivaryaddress(
          controller: controller2,
          labelText: "Last Name",
          hintText: "Last Name",
        ),
        const SizedBox(height: 18,),
        TextfieldDelivaryaddress(
          controller: controller2,
          labelText: "Address Finder",
          hintText: "Address Finder",
        ),
        const SizedBox(height: 18,),
        TextfieldDelivaryaddress(
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
              child: Text('Cancle'),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller2.clear();
              },
              child: Text('save'),
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
