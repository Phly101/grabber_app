import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
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


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final List<Map<String,dynamic>> itemsList = state.items.map((item) => {
          "title_ar": item.nameAr,
          "title_en":item.nameEn,
          "price": item.price,
          "quantity": item.quantity,
        }).toList();
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, AppRoutes.checkout);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(
              AppLocalizations.of(context)!.orderSummary,

              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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

                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                  trailing: Text(
                    "\$ ${state.totalPrice.toStringAsFixed(2)}",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Colors.white),
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
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> currentItem = itemsList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListItems(
                        title: LocalizationHelper.localizedProductField(currentItem, "title", context),
                        count: currentItem["quantity"] as num,
                        price: currentItem["price"] as num,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

