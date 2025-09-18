
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Profile/profile_tab.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/UI/Settings/drawer/app_drawer.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class MainScreen extends StatefulWidget {



  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  String dropdownValue = "Example street";


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,

  // Create a GlobalKey for Scaffold

      appBar: selectedIndex == 1
          ? null
          : AppBar(
              toolbarHeight: 120,

              leading: Image.asset(
                "Assets/Icons/motorcycleIcon.png",

                color: theme.colorScheme.onPrimary,

              ),
              title: DropdownButton(
                items: const [
                  DropdownMenuItem<String>(
                    value: "Example street",
                    child: Text("Example street"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Example street2",
                    child: Text("Example street2"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Example street3",
                    child: Text("Example street3"),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                value: dropdownValue,
              ),
              actions: [
                // Image.asset("Assets/Icons/CartIcon.png", color: Colors.black)  ,
                IconButton(

                  icon: const ImageIcon(
                    AssetImage("Assets/Icons/CartIcon.png"),
                  ),
                  onPressed: () {Navigator.pushNamed(context, AppRoutes.cart);
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
  HomeTab(),
  const SearchTab(),
  const ProfileTab(),

];
