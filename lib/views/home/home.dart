import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/models/menu_item.dart';
import 'package:taranis/providers/menu_provider.dart';
import 'package:taranis/views/home/main%20screen/main_screen.dart';
import 'package:taranis/views/home/menu%20screen/menu_screen.dart';
import 'package:taranis/widgets/awesome_drawer_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static List<MenuItem> mainMenu = const [
    MenuItem("news", Icons.newspaper_rounded, 0),
    MenuItem("search", Icons.search, 1),
    MenuItem("profile", Icons.person, 2),
  ];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = AwesomeDrawerBarController();
  final int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      isRTL: false,
      controller: _drawerController,
      type: StyleState.scaleRight,
      menuScreen: MenuScreen(
        HomeScreen.mainMenu,
        callback: _updatePage,
        current: _currentPage,
        key: UniqueKey(),
      ),
      mainScreen: const MainScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle!();
  }
}
