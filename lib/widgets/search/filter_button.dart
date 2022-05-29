import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/data.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/providers/data_provider.dart';

class FilterButton extends StatelessWidget {
  final int index;

  const FilterButton({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var category = categories[index];
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ElevatedButton(
          onPressed: () => context.read<DataProvider>().filterCategory(index),
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 0),
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(10)),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                category.isClicked ? primaryColor : Colors.transparent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: const BorderSide(color: primaryColor, width: 1),
                borderRadius: BorderRadius.circular(15.0))),
          ),
          child: Text(
            category.title.toUpperCase(),
            style: Theme.of(context).textTheme.headline5?.copyWith(
                fontSize: 17,
                color: category.isClicked ? Colors.white : Colors.black87),
          ),
        ));
  }
}