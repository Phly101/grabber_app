import "package:flutter/material.dart";

class PriceAndQuantity extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final Color subtitleColor;
  final Color backgroundColor;
  final Color textColor;

  const PriceAndQuantity({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.subtitleColor,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final price = product["price"] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$$price",
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xFF4CAF50),
            fontWeight: FontWeight.bold,
          ),
        ),
        // Quantity Selector integrated here
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (quantity > 0) onQuantityChanged(quantity - 1);
                },
                icon: const Icon(Icons.remove, size: 20),
                color: quantity > 0 ? const Color(0xFF4CAF50) : subtitleColor,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onQuantityChanged(quantity + 1),
                icon: const Icon(Icons.add, size: 20),
                color: const Color(0xFF4CAF50),
              ),
            ],
          ),
        ),
      ],
    );
  }
}