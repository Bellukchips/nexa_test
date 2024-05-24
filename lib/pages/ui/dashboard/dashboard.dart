import 'package:flutter/material.dart';
import 'package:nexa_test/pages/ui/dashboard/account/account_page.dart';
import 'package:nexa_test/pages/ui/dashboard/chat/chat_page.dart';
import 'package:nexa_test/pages/ui/dashboard/home/home_page.dart';
import 'package:nexa_test/pages/ui/dashboard/schedule/schedule_page.dart';
import 'package:nexa_test/shared/assets.dart';
import 'package:nexa_test/shared/color_app.dart';

import '../../components/custom_bottom_navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var selectedIndex = 0;
  List<NavItem> items = [
    NavItem(
      Image.asset(IconAssets.get(IconAssets.home)),
      Image.asset(IconAssets.get(IconAssets.homeActive)),
      const Text(
        "Home",
        style: TextStyle(color: Colors.blue),
      ),
      [ColorApp.blueOverlay, ColorApp.blueOverlay],
    ),
    NavItem(
      Image.asset(IconAssets.get(IconAssets.calendar)),
      Image.asset(IconAssets.get(IconAssets.calendarAtive)),
      const Text(
        "Jadwal",
        style: TextStyle(color: Colors.blue),
      ),
      [ColorApp.blueOverlay, ColorApp.blueOverlay],
    ),
    NavItem(
      Image.asset(IconAssets.get(IconAssets.message)),
      Image.asset(IconAssets.get(IconAssets.message)),
      const Text(
        "Pesan",
        style: TextStyle(color: Colors.blue),
      ),
      [ColorApp.blueOverlay, ColorApp.blueOverlay],
    ),
    NavItem(
      Image.asset(IconAssets.get(IconAssets.user)),
      Image.asset(IconAssets.get(IconAssets.user)),
      const Text(
        "Akun",
        style: TextStyle(color: Colors.blue),
      ),
      [ColorApp.blueOverlay, ColorApp.blueOverlay],
    ),
  ];

  Widget _buildList(NavItem item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: isSelected ? 125 : 50,
      decoration: isSelected
          ? BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: item.color),
              borderRadius: const BorderRadius.all(Radius.circular(12)))
          : null,
      padding: isSelected
          ? const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              isSelected ? item.secondImage : item.image,
              const SizedBox(
                width: 5,
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: const TextStyle(color: Colors.white),
                      child: item.title)
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget child;
    if (selectedIndex == 0) {
      child = const HomePage();
    } else if (selectedIndex == 3) {
      child = const AccountPage();
    } else if (selectedIndex == 1) {
      child = const SchedulePage();
    } else {
      child = const ChatPage();
    }
    return Container(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.map((i) {
                var itemIndex = items.indexOf(i);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = itemIndex;
                    });
                    if (itemIndex == 0) {
                      if (selectedIndex == 0) {
                        setState(() {});
                      } else {
                        setState(() {});
                      }
                    } else if (selectedIndex == 2) {
                      setState(() {});
                    } else if (selectedIndex == 1) {
                      setState(() {});
                    } else {
                      setState(() {});
                    }
                  },
                  child: _buildList(i, selectedIndex == itemIndex),
                );
              }).toList()),
        ),
        body: _buildBody(context));
  }
}
