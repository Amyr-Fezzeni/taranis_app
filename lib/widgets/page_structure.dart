import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:provider/provider.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/providers/menu_provider.dart';
import 'package:taranis/views/home/home.dart';
import 'package:taranis/views/news/news.dart';
import 'package:taranis/views/profile/profile_screen.dart';
import 'package:taranis/views/search/search_screen.dart';

import 'awesome_drawer_bar.dart';

class PageStructure extends StatelessWidget {
  String? title = "";
  final Widget child;
  final List<Widget> actions;
  final Color backgroundColor;
  final double elevation;

  PageStructure({
    required Key? key,
    this.title,
    required this.child,
    required this.actions,
    required this.backgroundColor,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const angle = 180 * pi / 180;

    final _currentPage =
        context.select<MenuProvider, int>((provider) => provider.currentPage);

    final container = Container(
      color: const Color.fromARGB(255, 31, 31, 31),
      child: Center(
        child: Text(
          "current : ${HomeScreen.mainMenu[_currentPage].title}",
          style: const TextStyle(color: primaryColor),
        ),
      ),
    );

    return PlatformScaffold(
        backgroundColor: Colors.transparent,
        appBar: PlatformAppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: PlatformText(
            HomeScreen.mainMenu[_currentPage].title,
          ),
          leading: Transform.rotate(
            angle: angle,
            child: PlatformIconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                AwesomeDrawerBar.of(context)?.toggle();
              },
            ),
          ),
          trailingActions: actions,
        ),
        bottomNavBar: PlatformNavBar(
          currentIndex: _currentPage,
          backgroundColor: bgColor,
          itemChanged: (index) =>
              Provider.of<MenuProvider>(context, listen: false)
                  .updateCurrentPage(index),
          items: HomeScreen.mainMenu
              .map(
                (item) => BottomNavigationBarItem(
                  activeIcon: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: bgColor,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: bgColor, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  backgroundColor: bgColor,
                  label: "",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Icon(
                      item.icon,
                      color: primaryColor,
                      size: 25,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        body: const [NewsScreen(), SearchScreen(), Profile()][_currentPage]);
  }
}
