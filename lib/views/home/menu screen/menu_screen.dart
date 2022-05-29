import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/models/menu_item.dart';
import 'package:taranis/providers/menu_provider.dart';
import 'package:taranis/providers/user_provider.dart';
import 'package:taranis/widgets/menu_item.dart';

class MenuScreen extends StatefulWidget {
  final List<MenuItem> mainMenu;
  final Function(int) callback;
  final int current;

  const MenuScreen(
    this.mainMenu, {
    required Key key,
    required this.callback,
    required this.current,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final widthBox = const SizedBox(
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 97, 86),
              Color.fromARGB(255, 41, 0, 0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24.0, left: 17, right: 17.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("assets/images/profile.jpg"),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.57,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 36.0, left: 17.0, right: 17.0),
                  child: Text(
                    context.read<UserProvider>().currentUser!.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Selector<MenuProvider, int>(
                selector: (_, provider) => provider.currentPage,
                builder: (_, index, __) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...widget.mainMenu
                        .map((item) => MenuItemWidget(
                              key: Key(item.index.toString()),
                              item: item,
                              callback: widget.callback,
                              widthBox: widthBox,
                              style: Theme.of(context).textTheme.bodyText1!,
                              selected: index == item.index,
                            ))
                        .toList()
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: OutlineButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "logout",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  onPressed: () => context.read<UserProvider>().logOut(context),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
