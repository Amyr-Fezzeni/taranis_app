import 'package:flutter/material.dart';
import 'package:taranis/models/menu_item.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItemModel item;
  final Widget widthBox;
  final TextStyle style;
  final Function callback;
  final bool selected;

  final white = Colors.white;

  const MenuItemWidget(
      {required Key key,
      required this.item,
      required this.widthBox,
      required this.style,
      required this.callback,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => callback(item.index),
      color: selected ? const Color.fromARGB(68, 60, 60, 60) : null,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item.icon,
            color: white,
            size: 24,
          ),
          widthBox,
          Expanded(
            child: Text(
              item.title,
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(color: white),
            ),
          )
        ],
      ),
    );
  }
}
