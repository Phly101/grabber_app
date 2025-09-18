import "package:flutter/material.dart";

import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Summary/Widgets/list_items.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../l10n/app_localizations.dart";
class SummaryScreen extends StatefulWidget {


  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<List> items = [
    ["4 bunch of banana (300g)", 3.45, 3],
    ["Bell peppers (400g)", 1.70, 2],
    ["Oranges (500g)", 6.30, 2],
    ["Purex (250ml)", 2.90, 1],
    ["Lemons (1Kg)", 7.88, 1],
    ["Quadratini biscuit", 1.45, 1],

  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      items=[
        [l10n.bananaBundle300g, 3.45, 3],
        [l10n.bellPeppers400g, 1.70, 2],
        [l10n.oranges500g, 6.30, 2],
        [l10n.purex250ml, 2.90, 1],
        [l10n.lemons1kg, 7.88, 1],
        [l10n.quadratiniBiscuit, 1.45, 1],
      ];
    },);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leading: IconButton(
          onPressed: () {

            Navigator.pushNamed(context, AppRoutes.checkout);

          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(

            AppLocalizations.of(context)!.orderSummary,

          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,

          child: Container(
            decoration: BoxDecoration(

              color: AppColors.textButtonColor,

              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(

                  AppLocalizations.of(context)!.subtotal,

                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
              trailing: Text(
                "\$ ${subTotal(items).toStringAsFixed(2)}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),

            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListItems(
                  title: items[index][0],
                  count: items[index][2],
                  price: items[index][1],
                ),
              ),

              itemCount: items.length,
            ),

          ],
        ),
      ),
    );
  }
}


num subTotal(List<List> prices) {
  num subTotal = 0;
  for (int i = 0; i < prices.length; i++) {
    subTotal += prices[i][1] * prices[i][2];
  }
  return subTotal;
}
