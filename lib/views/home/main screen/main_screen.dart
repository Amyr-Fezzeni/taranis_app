import 'package:flutter/material.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/widgets/awesome_drawer_bar.dart';
import 'package:taranis/widgets/page_structure.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<DrawerState>? listenable =
        AwesomeDrawerBar.of(context)?.stateNotifier;

    const rtl = false;

    return ValueListenableBuilder<DrawerState>(
      valueListenable: listenable!,
      builder: (context, state, child) {
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: GestureDetector(
        child: PageStructure(
          elevation: 10,
          actions: const [],
          backgroundColor: bgColor,
          key: UniqueKey(),
          child: Container(),
        ),
        onPanUpdate: (details) {
          if (details.delta.dx < 6 && !rtl || details.delta.dx < -6 && rtl) {
            AwesomeDrawerBar.of(context)?.toggle();
          }
        },
      ),
    );
  }
}
