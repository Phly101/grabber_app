import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcomeBackToGrabber.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back To Grabber'**
  String get welcomeBackToGrabber;

  /// No description provided for @pleaseSignInWithYourMail.
  ///
  /// In en, this message translates to:
  /// **'Please sign in with your mail'**
  String get pleaseSignInWithYourMail;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'enter your name'**
  String get enterYourName;

  /// No description provided for @userNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'User Name is required'**
  String get userNameIsRequired;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'enter your password'**
  String get enterYourPassword;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordMustBeAtLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMustBeAtLeast8Characters;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'enter your full name'**
  String get enterYourFullName;

  /// No description provided for @fullNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Full Name is required'**
  String get fullNameIsRequired;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'enter your mobile number'**
  String get enterYourMobileNumber;

  /// No description provided for @mobileNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number is required'**
  String get mobileNumberIsRequired;

  /// No description provided for @enterAValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get enterAValidNumber;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'E-mail address'**
  String get emailAddress;

  /// No description provided for @enterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'enter your email address'**
  String get enterYourEmailAddress;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @enterAValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterAValidEmail;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmYourPasswords.
  ///
  /// In en, this message translates to:
  /// **'confirm your passwords'**
  String get confirmYourPasswords;

  /// No description provided for @pleaseConfirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @alexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get alexandria;

  /// No description provided for @cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get cairo;

  /// No description provided for @giza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get giza;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @pleaseSelectACity.
  ///
  /// In en, this message translates to:
  /// **'Please select a city'**
  String get pleaseSelectACity;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationTitle;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent!'**
  String get verificationEmailSent;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email verified ✅'**
  String get emailVerified;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email not verified yet ❌'**
  String get emailNotVerified;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(Object message);

  /// No description provided for @verificationInstruction.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification link to your email.\nPlease check your inbox.'**
  String get verificationInstruction;

  /// No description provided for @checkNowButton.
  ///
  /// In en, this message translates to:
  /// **'I\'ve verified, Check now'**
  String get checkNowButton;

  /// No description provided for @resendEmailButton.
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Email'**
  String get resendEmailButton;

  /// No description provided for @verificationCooldown.
  ///
  /// In en, this message translates to:
  /// **'Verification link valid for 10 seconds...'**
  String get verificationCooldown;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @proceedingToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceeding to Checkout...'**
  String get proceedingToCheckout;

  /// No description provided for @bananaBundle300g.
  ///
  /// In en, this message translates to:
  /// **'4 bunch of banana (300g)'**
  String get bananaBundle300g;

  /// No description provided for @price345.
  ///
  /// In en, this message translates to:
  /// **'\$3.45'**
  String get price345;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @priority1020Mins.
  ///
  /// In en, this message translates to:
  /// **'Priority (10 - 20 mins)'**
  String get priority1020Mins;

  /// No description provided for @standard3045Mins.
  ///
  /// In en, this message translates to:
  /// **'Standard (30 - 45 mins)'**
  String get standard3045Mins;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @orderSummary12Items.
  ///
  /// In en, this message translates to:
  /// **'Order Summary (12 items)'**
  String get orderSummary12Items;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal: '**
  String get subtotal;

  /// No description provided for @bagFee.
  ///
  /// In en, this message translates to:
  /// **'Bag fee: '**
  String get bagFee;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service fee: '**
  String get serviceFee;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery: '**
  String get delivery;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total: '**
  String get total;

  /// No description provided for @requestAnInvoice.
  ///
  /// In en, this message translates to:
  /// **'Request an invoice'**
  String get requestAnInvoice;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @fruits.
  ///
  /// In en, this message translates to:
  /// **'Fruits'**
  String get fruits;

  /// No description provided for @milkAndEgg.
  ///
  /// In en, this message translates to:
  /// **'Milk & egg'**
  String get milkAndEgg;

  /// No description provided for @beverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get beverages;

  /// No description provided for @laundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry'**
  String get laundry;

  /// No description provided for @vegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetables;

  /// No description provided for @banana.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get banana;

  /// No description provided for @pepper.
  ///
  /// In en, this message translates to:
  /// **'Pepper'**
  String get pepper;

  /// No description provided for @orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orange;

  /// No description provided for @strawberry.
  ///
  /// In en, this message translates to:
  /// **'Strawberry'**
  String get strawberry;

  /// No description provided for @lemon.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get lemon;

  /// No description provided for @waterMelon.
  ///
  /// In en, this message translates to:
  /// **'Water Melon'**
  String get waterMelon;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @mango.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get mango;

  /// No description provided for @grapes.
  ///
  /// In en, this message translates to:
  /// **'Grapes'**
  String get grapes;

  /// No description provided for @pawPaw.
  ///
  /// In en, this message translates to:
  /// **'Paw Paw'**
  String get pawPaw;

  /// No description provided for @detergent.
  ///
  /// In en, this message translates to:
  /// **'Detergent'**
  String get detergent;

  /// No description provided for @biscuit.
  ///
  /// In en, this message translates to:
  /// **'Biscuit'**
  String get biscuit;

  /// No description provided for @purex.
  ///
  /// In en, this message translates to:
  /// **'Purex'**
  String get purex;

  /// No description provided for @varnish.
  ///
  /// In en, this message translates to:
  /// **'Varnish'**
  String get varnish;

  /// No description provided for @tide.
  ///
  /// In en, this message translates to:
  /// **'Tide'**
  String get tide;

  /// No description provided for @harpic.
  ///
  /// In en, this message translates to:
  /// **'Harpic'**
  String get harpic;

  /// No description provided for @dettol.
  ///
  /// In en, this message translates to:
  /// **'Dettol'**
  String get dettol;

  /// No description provided for @locker.
  ///
  /// In en, this message translates to:
  /// **'Locker'**
  String get locker;

  /// No description provided for @biscoff.
  ///
  /// In en, this message translates to:
  /// **'Biscoff'**
  String get biscoff;

  /// No description provided for @tuc.
  ///
  /// In en, this message translates to:
  /// **'TUC'**
  String get tuc;

  /// No description provided for @filter_products.
  ///
  /// In en, this message translates to:
  /// **'Filter Products'**
  String get filter_products;

  /// No description provided for @price_range.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @apply_filter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get apply_filter;

  /// No description provided for @milk_egg.
  ///
  /// In en, this message translates to:
  /// **'Milk & Egg'**
  String get milk_egg;

  /// No description provided for @filtered_results.
  ///
  /// In en, this message translates to:
  /// **'Filtered Results'**
  String get filtered_results;

  /// No description provided for @no_products_match_filter.
  ///
  /// In en, this message translates to:
  /// **'No products match your filter'**
  String get no_products_match_filter;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @rating48With287.
  ///
  /// In en, this message translates to:
  /// **'4.8 (287)'**
  String get rating48With287;

  /// No description provided for @offer30.
  ///
  /// In en, this message translates to:
  /// **'Up to 30% offer'**
  String get offer30;

  /// No description provided for @offer25.
  ///
  /// In en, this message translates to:
  /// **'Up to 25% offer'**
  String get offer25;

  /// No description provided for @getSameDayDeliver.
  ///
  /// In en, this message translates to:
  /// **'Get Same day\nDeliver'**
  String get getSameDayDeliver;

  /// No description provided for @enjoyOurBigOffer.
  ///
  /// In en, this message translates to:
  /// **'Enjoy our big offer'**
  String get enjoyOurBigOffer;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiry;

  /// No description provided for @cvc.
  ///
  /// In en, this message translates to:
  /// **'CVC'**
  String get cvc;

  /// No description provided for @payWithCard.
  ///
  /// In en, this message translates to:
  /// **'Pay with card'**
  String get payWithCard;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get cardNumber;

  /// No description provided for @confirmAndPay49.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Pay (\$49.00)'**
  String get confirmAndPay49;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @userExample.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get userExample;

  /// No description provided for @makeChangesToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Make changes to your account'**
  String get makeChangesToYourAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @furtherSecureYourAccountForSafety.
  ///
  /// In en, this message translates to:
  /// **'Further secure your account for safety'**
  String get furtherSecureYourAccountForSafety;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @itunuoluwaAbidoye.
  ///
  /// In en, this message translates to:
  /// **'Itunuoluwa Abidoye'**
  String get itunuoluwaAbidoye;

  /// No description provided for @itunuoluwaHandle.
  ///
  /// In en, this message translates to:
  /// **'@Itunuoluwa'**
  String get itunuoluwaHandle;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @scheduleDelivery.
  ///
  /// In en, this message translates to:
  /// **'Schedule Delivery'**
  String get scheduleDelivery;

  /// No description provided for @timeSlots.
  ///
  /// In en, this message translates to:
  /// **'Time Slots'**
  String get timeSlots;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get saveAndContinue;

  /// No description provided for @time0800to0930.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM – 09:30 AM'**
  String get time0800to0930;

  /// No description provided for @time1000to1115.
  ///
  /// In en, this message translates to:
  /// **'10:00 AM – 11:15 AM'**
  String get time1000to1115;

  /// No description provided for @time1230to0145v.
  ///
  /// In en, this message translates to:
  /// **'12:30 PM – 01:45 PM'**
  String get time1230to0145v;

  /// No description provided for @time0300to0415.
  ///
  /// In en, this message translates to:
  /// **'03:00 PM – 04:15 PM'**
  String get time0300to0415;

  /// No description provided for @time0530to0645.
  ///
  /// In en, this message translates to:
  /// **'05:30 PM – 06:45 PM'**
  String get time0530to0645;

  /// No description provided for @time0800to0915.
  ///
  /// In en, this message translates to:
  /// **'08:00 PM – 09:15 PM'**
  String get time0800to0915;

  /// No description provided for @time0630to0700.
  ///
  /// In en, this message translates to:
  /// **'06:30 AM – 07:00 AM'**
  String get time0630to0700;

  /// No description provided for @noSuggestionsFoundFor.
  ///
  /// In en, this message translates to:
  /// **'No suggestions found for \"%s\"'**
  String get noSuggestionsFoundFor;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @pineapple.
  ///
  /// In en, this message translates to:
  /// **'Pineapple'**
  String get pineapple;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @extraDark.
  ///
  /// In en, this message translates to:
  /// **'Extra Dark'**
  String get extraDark;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings tab...'**
  String get settingsTab;

  /// No description provided for @bellPeppers400g.
  ///
  /// In en, this message translates to:
  /// **'Bell peppers (400g)'**
  String get bellPeppers400g;

  /// No description provided for @oranges500g.
  ///
  /// In en, this message translates to:
  /// **'Oranges (500g)'**
  String get oranges500g;

  /// No description provided for @purex250ml.
  ///
  /// In en, this message translates to:
  /// **'Purex (250ml)'**
  String get purex250ml;

  /// No description provided for @lemons1kg.
  ///
  /// In en, this message translates to:
  /// **'Lemons (1Kg)'**
  String get lemons1kg;

  /// No description provided for @quadratiniBiscuit.
  ///
  /// In en, this message translates to:
  /// **'Quadratini biscuit'**
  String get quadratiniBiscuit;

  /// No description provided for @noSuggestionsFound.
  ///
  /// In en, this message translates to:
  /// **'No suggestions found for'**
  String get noSuggestionsFound;

  /// No description provided for @price1.
  ///
  /// In en, this message translates to:
  /// **'EGP 5.29'**
  String get price1;

  /// No description provided for @price2.
  ///
  /// In en, this message translates to:
  /// **'EGP 2.99'**
  String get price2;

  /// No description provided for @price3.
  ///
  /// In en, this message translates to:
  /// **'EGP 3.99'**
  String get price3;

  /// No description provided for @price4.
  ///
  /// In en, this message translates to:
  /// **'EGP 1.99'**
  String get price4;

  /// No description provided for @price5.
  ///
  /// In en, this message translates to:
  /// **'EGP 1.99'**
  String get price5;

  /// No description provided for @price6.
  ///
  /// In en, this message translates to:
  /// **'EGP 1.99'**
  String get price6;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @rating1.
  ///
  /// In en, this message translates to:
  /// **'4.8 (287)'**
  String get rating1;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get developedBy;

  /// No description provided for @developerEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get developerEmail;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @viewOpenSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'View Open Source Licenses'**
  String get viewOpenSourceLicenses;

  /// No description provided for @appDescriptionLine1.
  ///
  /// In en, this message translates to:
  /// **'Grabber is your smart shopping list companion.'**
  String get appDescriptionLine1;

  /// No description provided for @appDescriptionLine2.
  ///
  /// In en, this message translates to:
  /// **'Easily add groceries, track quantities, and stay organized.'**
  String get appDescriptionLine2;

  /// No description provided for @appDescriptionLine3.
  ///
  /// In en, this message translates to:
  /// **'Whether at home or in the store, Grabber keeps your shopping hassle-free.'**
  String get appDescriptionLine3;

  /// No description provided for @deliverToCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Deliver to your current location'**
  String get deliverToCurrentLocation;

  /// No description provided for @upiPay.
  ///
  /// In en, this message translates to:
  /// **'UPI Pay'**
  String get upiPay;

  /// No description provided for @scanAndPay.
  ///
  /// In en, this message translates to:
  /// **'Scan & Pay'**
  String get scanAndPay;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @updateName.
  ///
  /// In en, this message translates to:
  /// **'Update Name'**
  String get updateName;

  /// No description provided for @updatePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Update Phone Number'**
  String get updatePhoneNumber;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @loadingProfileData.
  ///
  /// In en, this message translates to:
  /// **'Loading Profile Data...'**
  String get loadingProfileData;

  /// No description provided for @failedToLoadProfileData.
  ///
  /// In en, this message translates to:
  /// **'Failed To Load Profile Data'**
  String get failedToLoadProfileData;

  /// No description provided for @dataUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data Updated Successfully'**
  String get dataUpdatedSuccessfully;

  /// No description provided for @failedToUpdateData.
  ///
  /// In en, this message translates to:
  /// **'Failed To Update Data'**
  String get failedToUpdateData;

  /// No description provided for @sendAsAGift.
  ///
  /// In en, this message translates to:
  /// **'Send as a gift'**
  String get sendAsAGift;

  /// No description provided for @sendGift.
  ///
  /// In en, this message translates to:
  /// **'Send Gift!'**
  String get sendGift;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPassword;

  /// No description provided for @currentPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Current password cannot be empty'**
  String get currentPasswordEmpty;

  /// No description provided for @passwordMustBeAtLeast6Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeast6Characters;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @newPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'New password cannot be empty'**
  String get newPasswordEmpty;

  /// No description provided for @newPasswordDifferent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password'**
  String get newPasswordDifferent;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmNewPassword;

  /// No description provided for @reEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get reEnterNewPassword;

  /// No description provided for @confirmPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Confirm password cannot be empty'**
  String get confirmPasswordEmpty;

  /// No description provided for @sendingRequest.
  ///
  /// In en, this message translates to:
  /// **'Sending your request ...'**
  String get sendingRequest;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in ...'**
  String get loggingIn;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful 🎉'**
  String get loginSuccessful;

  /// No description provided for @signingUp.
  ///
  /// In en, this message translates to:
  /// **'Signing up...'**
  String get signingUp;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @enterGiftEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter the email of whom you want to gift'**
  String get enterGiftEmail;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully!'**
  String get passwordResetEmailSent;

  /// No description provided for @emailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailCannotBeEmpty;

  /// No description provided for @confirmGift.
  ///
  /// In en, this message translates to:
  /// **'Confirm Gift'**
  String get confirmGift;

  /// No description provided for @areYouSureGift.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to send a gift to'**
  String get areYouSureGift;

  /// No description provided for @sendingGiftTo.
  ///
  /// In en, this message translates to:
  /// **'Sending gift to'**
  String get sendingGiftTo;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailAlreadyInUse;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid.'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get weakPassword;

  /// No description provided for @noUserSignedIn.
  ///
  /// In en, this message translates to:
  /// **'No user is currently signed in.'**
  String get noUserSignedIn;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided.'**
  String get wrongPassword;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Account not found. Please, sign up.'**
  String get invalidCredential;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknownError;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully.'**
  String get passwordResetSent;

  /// No description provided for @reauthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Reauthentication failed.'**
  String get reauthenticationFailed;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'The current password is incorrect.'**
  String get currentPasswordIncorrect;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully!'**
  String get passwordChangedSuccessfully;

  /// No description provided for @couldNotUpdatePassword.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update your password.'**
  String get couldNotUpdatePassword;

  /// No description provided for @requiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again before changing password.'**
  String get requiresRecentLogin;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out ...'**
  String get loggingOut;

  /// No description provided for @myGifts.
  ///
  /// In en, this message translates to:
  /// **'🎁 My Gifts'**
  String get myGifts;

  /// No description provided for @noGiftsYet.
  ///
  /// In en, this message translates to:
  /// **'No gifts yet!'**
  String get noGiftsYet;

  /// No description provided for @startSharingGifts.
  ///
  /// In en, this message translates to:
  /// **'Start sharing the gifts!'**
  String get startSharingGifts;

  /// No description provided for @errorLoadingGifts.
  ///
  /// In en, this message translates to:
  /// **'Error loading gifts:'**
  String get errorLoadingGifts;

  /// No description provided for @preparingYourGifts.
  ///
  /// In en, this message translates to:
  /// **'Preparing your gifts...'**
  String get preparingYourGifts;

  /// No description provided for @noUserFoundForThatEmail.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get noUserFoundForThatEmail;

  /// No description provided for @wrongPasswordProvided.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided.'**
  String get wrongPasswordProvided;

  /// No description provided for @accountNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account not found.'**
  String get accountNotFound;

  /// No description provided for @pleaseSignInAgainBeforeChangingPassword.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again before changing your password.'**
  String get pleaseSignInAgainBeforeChangingPassword;

  /// No description provided for @unknownErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknownErrorOccurred;

  /// No description provided for @confirmAndPayGift.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Pay Gift'**
  String get confirmAndPayGift;

  /// No description provided for @failedToSendGift.
  ///
  /// In en, this message translates to:
  /// **'Failed to send gift.'**
  String get failedToSendGift;

  /// No description provided for @giftSentSuccessfullyCartCleared.
  ///
  /// In en, this message translates to:
  /// **'Gift sent successfully! Cart cleared.'**
  String get giftSentSuccessfullyCartCleared;

  /// No description provided for @invalidExpiryFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid format. Use MM/YY or MM/YYYY.'**
  String get invalidExpiryFormat;

  /// No description provided for @cardExpired.
  ///
  /// In en, this message translates to:
  /// **'Card expired.'**
  String get cardExpired;

  /// No description provided for @expiryYearTooFar.
  ///
  /// In en, this message translates to:
  /// **'Expiry year too far in the future.'**
  String get expiryYearTooFar;

  /// No description provided for @cvcRequired.
  ///
  /// In en, this message translates to:
  /// **'CVC is required.'**
  String get cvcRequired;

  /// No description provided for @invalidCvc.
  ///
  /// In en, this message translates to:
  /// **'Invalid CVC. Must be 3 or 4 digits.'**
  String get invalidCvc;

  /// No description provided for @mmYY.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get mmYY;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// No description provided for @couldntFindTheUser.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the user'**
  String get couldntFindTheUser;

  /// No description provided for @cardNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Card number is required.'**
  String get cardNumberIsRequired;

  /// No description provided for @cardNumberMustContainOnlyDigits.
  ///
  /// In en, this message translates to:
  /// **'Card number must contain only digits.'**
  String get cardNumberMustContainOnlyDigits;

  /// No description provided for @invalidCardNumberLength.
  ///
  /// In en, this message translates to:
  /// **'Invalid card number length.'**
  String get invalidCardNumberLength;

  /// No description provided for @onlyVisaOrMasterCard.
  ///
  /// In en, this message translates to:
  /// **'Only Visa or MasterCard are accepted.'**
  String get onlyVisaOrMasterCard;

  /// No description provided for @invalidCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid card number.'**
  String get invalidCardNumber;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty: '**
  String get qty;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price:'**
  String get price;

  /// No description provided for @unknownTime.
  ///
  /// In en, this message translates to:
  /// **'Unknown time'**
  String get unknownTime;

  /// No description provided for @giftDetails.
  ///
  /// In en, this message translates to:
  /// **'Gift Details'**
  String get giftDetails;

  /// No description provided for @giftItems.
  ///
  /// In en, this message translates to:
  /// **'Gift Items:'**
  String get giftItems;

  /// No description provided for @noItemsInGift.
  ///
  /// In en, this message translates to:
  /// **'No items in this gift.'**
  String get noItemsInGift;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @receivedOn.
  ///
  /// In en, this message translates to:
  /// **'Received on'**
  String get receivedOn;

  /// No description provided for @enjoyYourGift.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your gift!'**
  String get enjoyYourGift;

  /// No description provided for @swipeToDelete.
  ///
  /// In en, this message translates to:
  /// **'Swipe an item to delete'**
  String get swipeToDelete;

  /// No description provided for @cartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartIsEmpty;

  /// No description provided for @unknownDate.
  ///
  /// In en, this message translates to:
  /// **'Unknown date'**
  String get unknownDate;


  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add tO cart'**
  String get addToCart;

  /// No description provided for @otherProducts.
  ///
  /// In en, this message translates to:
  /// **'Other products'**
  String get otherProducts;

  /// No description provided for @noProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get noProductsAvailable;

  /// No description provided for @errorLoadingProducts.
  ///
  /// In en, this message translates to:
  /// **'Error loading products'**
  String get errorLoadingProducts;

  /// No description provided for @aReliableHighQualityProductDesignedToMakeEverydayLifeEasierAndBetterPerfectForDailyUseWithGreatValueAndFreshness.
  ///
  /// In en, this message translates to:
  /// **'A reliable, high-quality product designed to make everyday life easier and better. Perfect for daily use with great value and freshness.'**
  String get aReliableHighQualityProductDesignedToMakeEverydayLifeEasierAndBetterPerfectForDailyUseWithGreatValueAndFreshness;

  String get allGiftsDeleted;
  String get tapToClearNotifications;

}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
