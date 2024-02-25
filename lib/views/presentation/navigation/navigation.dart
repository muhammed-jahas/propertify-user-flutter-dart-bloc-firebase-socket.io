import 'package:flutter/material.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/views/coming_soon/coming_soon.dart';
import 'package:propertify/views/history_screen/history_screen.dart';
import 'package:propertify/views/presentation/home_screen/home_screen.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/views/presentation/inbox_screen/inbox_screen.dart';
import 'package:propertify/views/presentation/profile_screen/profile_screen.dart';
import 'package:propertify/views/presentation/search_screen/search_screen.dart';

class NavigationItems extends StatefulWidget {
  int? newindex;
  NavigationItems({Key? key, this.newindex});

  @override
  State<NavigationItems> createState() => _NavigationItemsState();
}

class _NavigationItemsState extends State<NavigationItems> {
  
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    // ComingSoon(),
    
    InboxScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.newindex ?? 0;
  }
  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade500,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            enableFeedback: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.home,
                      color: AppColors.secondaryColor),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.home),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.search,
                      color: AppColors.secondaryColor),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.search),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.chat,
                      color: AppColors.secondaryColor),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.chat),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.recent,
                      color: AppColors.secondaryColor),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.recent),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.user,
                      color: AppColors.secondaryColor),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(PropertifyIcons.user),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
