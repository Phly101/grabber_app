import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/slider_widget.dart";

class OfferScreen extends StatefulWidget {
  const OfferScreen({
    super.key,
  });

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late final Map<String, dynamic> args;
  late final Map<String, dynamic> slide;
  late final int index;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    slide = args["slide"] as Map<String, dynamic>;
    index = args["index"] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Hero(
              tag: "slide_$index",
              child: SliderWidget(slide: slide),
            ),
          ],
        ),
      ),
    );
  }
}
