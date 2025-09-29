import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class ShimmerImage extends StatelessWidget {
  final double size;
  const ShimmerImage({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        color: Colors.grey.shade300,
      ),
    );
  }
}
