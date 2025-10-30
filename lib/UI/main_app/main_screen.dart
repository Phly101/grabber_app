import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Profile/profile_tab.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/UI/Settings/drawer/app_drawer.dart";
import "package:grabber_app/UI/gift/gift_page.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:badges/badges.dart" as badges;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    final giftBloc = context.read<GiftBloc>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      giftBloc.add(ListenToGifts(userId));
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBloc = context.read<AppThemeBloc>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: selectedIndex == 1
          ? null
          : AppBar(
              toolbarHeight: 120,
              leading: Center(
                child: FaIcon(
                  FontAwesomeIcons.motorcycle,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              title: themeBloc.state.appTheme == "L"
                  ? Image.asset("Assets/Images/Grabber1.png")
                  : Image.asset("Assets/Images/Grabber.png"),

              actions: [
                BlocBuilder<GiftBloc, SendGiftState>(
                  builder: (context, state) {
                    int notificationCount = 0;

                    if (state is GiftStreamUpdated) {
                      notificationCount = state.gifts.length;
                    } else if (state is NotificationsLoaded) {
                      notificationCount = state.notifications.length;
                    }

                    return IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<GiftBloc>(),
                              child: const GiftsPage(),
                            ),
                          ),
                        );
                      },
                      icon: badges.Badge(
                        badgeContent: Text(
                          notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        showBadge: notificationCount > 0,
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                BlocSelector<CartBloc, CartState, int>(
                  selector: (state) => state.totalItems,
                  builder: (context, totalItems) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: badges.Badge(
                          badgeContent: Text(
                            totalItems.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          showBadge: totalItems > 0,
                          child: FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.cart);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

      body: tabs[selectedIndex],

      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        onTap: (index) {
          if (index == 3) {
            _scaffoldKey.currentState?.openEndDrawer();
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },

        currentIndex: selectedIndex,
        selectedColor: AppColors.primaryGreen,
        unSelectedColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.surface,
        selectedIconSize: 25,
        selectedFontSize: 15,
        unselectedIconSize: 20,
        unselectedFontSize: 12,
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.top,

        customBottomBarItems: [
          CustomBottomBarItems(
            isAssetsImage: false,
            label: AppLocalizations.of(context)!.home,

            icon: Icons.home,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,

            label: AppLocalizations.of(context)!.search,

            icon: Icons.search,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,

            label: AppLocalizations.of(context)!.profile,

            icon: Icons.person,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,

            label: AppLocalizations.of(context)!.settings,

            icon: Icons.settings,
          ),
        ],
      ),

      endDrawer: const AppDrawer(),
    );
  }
}

var tabs = [
  const HomeTab(),
  const SearchTab(),
  const ProfileTab(),
];
