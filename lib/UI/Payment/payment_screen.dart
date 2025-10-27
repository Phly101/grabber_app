import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Payment/Widget/confirm_payment_dialog.dart";
import "package:grabber_app/UI/Payment/Widget/custom_card.dart";
import "package:grabber_app/UI/Payment/Widget/custom_row.dart";
import "package:grabber_app/UI/Payment/Widget/custom_text_field.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:shimmer/shimmer.dart";
import "../../../../l10n/app_localizations.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardExpiryController = TextEditingController();
  final _cardCvcController = TextEditingController();
  String option = "Pay with card";
  String? currentOption;
  String? receiverEmail;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    option = AppLocalizations.of(context)!.payWithCard;
    currentOption = option;
    // NOTE: If this ModalRoute.of(context)!.settings.arguments is null
    // when running the test, it would cause a Null Check crash (which you fixed
    // by adding the L10n delegates, suggesting the argument wasn't the issue).
    receiverEmail = ModalRoute.of(context)!.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<GiftBloc, SendGiftState>(
      listener: (context, state) {
        if (state is SendGiftSuccess) {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthAuthenticated) {
            context.read<CartBloc>().add(ClearUserCart(authState.user.uid));
          }

          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.giftSentSuccessfullyCartCleared,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.mainApp,
                (route) => false,
          );
        }

        if (state is SendGiftFailure) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.failedToSendGift,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            AppLocalizations.of(context)!.payment,
            style: Theme.of(context).textTheme.titleLarge,
            // 🔑 KEY 1: paymentScreenTitle is correct here
            key: const Key("paymentScreenTitle"),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                  height: 2,
                ),
                CustomRow(option: option, url: "Assets/Icons/credit-card.png"),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    AppLocalizations.of(context)!.cardNumber,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    // ⚠️ REMOVED KEY: The key was incorrectly placed on the Text label
                    // key: const Key(("cardNumberField")),
                  ),
                ),
                CardNumberField(
                  controller: _cardNumberController,
                  // 🔑 KEY 2: Placed key on the actual input widget
                  key: const Key("cardNumberField"),
                ),
                CustomCard(
                  expiryController: _cardExpiryController,
                  cvcController: _cardCvcController,
                ),
                BlocBuilder<GiftBloc, SendGiftState>(
                  builder: (context, state) {
                    final isGiftMode = state is GiftModeEnabled;

                    return isGiftMode
                        ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                PaymentConfirmDialog.show(
                                  context: context,
                                  isGiftMode: isGiftMode,
                                  receiverEmail: receiverEmail,
                                );
                                _cardCvcController.clear();
                                _cardExpiryController.clear();
                                _cardNumberController.clear();
                              }
                            },
                            // NOTE: This button is not found in the initial state of the test
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.textButtonColor,
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.confirmAndPay49,
                                  style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                PaymentConfirmDialog.show(
                                  context: context,
                                  isGiftMode: isGiftMode,
                                  receiverEmail: receiverEmail,
                                );
                                _cardCvcController.clear();
                                _cardExpiryController.clear();
                                _cardNumberController.clear();

                              }
                            },
                            child: Stack(
                              children: [
                                Shimmer(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffFFD700),
                                      Colors.white,
                                      Color(0xffFFD700),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.1, 0.5, 0.9],
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: const Color(0xffFFD700),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.confirmAndPayGift,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                        : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            PaymentConfirmDialog.show(
                              context: context,
                              isGiftMode: isGiftMode,
                              receiverEmail: receiverEmail,
                            );
                            _cardCvcController.clear();
                            _cardExpiryController.clear();
                            _cardNumberController.clear();
                          }
                        },
                        // 🔑 KEY 3: This is the button visible when GiftMode is OFF (initial state in test)
                        key: const Key("confirmAndPayButton"),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.textButtonColor,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.confirmAndPay49,
                              style:
                              Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}