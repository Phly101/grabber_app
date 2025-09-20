import "package:flutter/material.dart";
import "package:grabber_app/LocalizationHelper/localizationHelper.dart";

import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Summary/Widgets/list_items.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../l10n/app_localizations.dart";
class SummaryScreen extends StatelessWidget {

  List<List> items = [
    ["bananaBundle300g", 3.45, 3],
    ["bellPeppers400g", 1.70, 2],
    ["oranges500g", 6.30, 2],
    ["purex250ml", 2.90, 1],
    ["lemons1kg", 7.88, 1],
    ["quadratiniBiscuit", 1.45, 1],

  ];

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
                  title:LocalizationHelper.getString(context, items[index][0]),
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
