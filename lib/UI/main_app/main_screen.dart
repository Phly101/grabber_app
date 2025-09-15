import 'package:flutter/material.dart';
import 'package:grabber_app/UI/Cart/view/cart_page.dart';
import 'package:grabber_app/UI/Profile/profile_tab.dart';
import 'package:grabber_app/UI/Search/search_tab.dart';
import 'package:grabber_app/UI/Settings/drawer/app_drawer.dart';
// import 'package:grabber_app/UI/Settings/settings_tab.dart';
import 'package:grabber_app/UI/home/home_tab.dart';
import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "MainScreen";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  String dropdownValue = "Example street";

  // Create a GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey, //attach the key here 
      appBar: selectedIndex == 1
          ? null
          : AppBar(
              toolbarHeight: 120,

              leading: Image.asset(
                "Assets/Icons/motorcycleIcon.png",
                color: Colors.black,
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
                  icon: ImageIcon(AssetImage("Assets/Icons/CartIcon.png")),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(), 
                        ),
                      );
                    },
                  )
              ],
            ),

      body: tabs[selectedIndex],

      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        onTap: (index) {
          if (index == 3) {
            _scaffoldKey.currentState?.openEndDrawer();
          }
          else{
          setState(() {
            selectedIndex = index;
          });
          }
        },

        currentIndex: selectedIndex,
        selectedColor: Theme.of(context).colorScheme.secondary,
        unSelectedColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
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
            label: "Home",
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,
            label: "Search",
            icon: Icons.search,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,
            label: "Profile",
            icon: Icons.person,
          ),
          CustomBottomBarItems(
            isAssetsImage: false,
            label: "Settings",
            icon: Icons.settings,
          ),
        ],
      ),
      endDrawer: AppDrawer(),
    );
  }
}

var tabs = [
  const HomeTab(),
  const SearchTab(),
  const ProfileTab(),
  // const SettingsTab(),
];
