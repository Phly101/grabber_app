import 'package:flutter/material.dart';

class DeliverySection extends StatelessWidget {
  final String? deliveryType;
  final ValueChanged<String?> onChanged;

  const DeliverySection({
    super.key,
    required this.deliveryType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Priority (10 -20 mins)"),
          leading: Image.asset("Assets/Icons/carbon_receipt.png"),
          trailing: Radio(
            value: "Priority",
            groupValue: deliveryType,
            activeColor: const Color(0xFF0CA201),
            onChanged: onChanged,
          ),
          onTap: () => onChanged("Priority"),
        ),
        const Divider(height: 1, thickness: 2,color: Color(0xFFECECEC)),
        ListTile(
          title: Text("Standard (30 - 45 mins)"),
          leading: Image.asset("Assets/Icons/fluent_receipt-28-regular.png"),
          trailing: Radio(
            value: "Standard",
            groupValue: deliveryType,
            activeColor: const Color(0xFF0CA201),
            onChanged: onChanged,
          ),
          onTap: () => onChanged("Standard"),
        ),
        const Divider(height: 1, thickness: 2,color: Color(0xFFECECEC)),
        ListTile(
          title: Text("Schedule"),
          leading: Image.asset("Assets/Icons/icon-park-outline_time.png"),
          trailing: Image.asset("Assets/Icons/chevron-right.png"),
        ),
      ],
    );
  }
}
