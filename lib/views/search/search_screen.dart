import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/data.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/widgets/news/news_card.dart';
import 'package:taranis/widgets/search/filter_button.dart';

import '../../providers/data_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = ScrollController();
  bool isDown = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => context.read<DataProvider>().filterCategory(0));
    controller.addListener(() {
      if (controller.offset > 100) {
        if (isDown == false) {
          setState(() {
            isDown = true;
          });
        }
      } else {
        if (isDown == true) {
          setState(() {
            isDown = false;
          });
        }
      }
      if (controller.position.maxScrollExtent == controller.offset) {
        if (!context.read<DataProvider>().isOffset) {
          context.read<DataProvider>().loadMoreCategory();
        }
      }
    });
  }

  Future<void> _refrech() async {
    context
        .read<DataProvider>()
        .filterCategory(context.read<DataProvider>().currestCategoryKey);
    return;
  }

  @override
  Widget build(BuildContext context) {
    var dataWatch = context.watch<DataProvider>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: isDown
          ? FloatingActionButton(
              onPressed: () => controller.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              backgroundColor: secondColor,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: _refrech,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          child: SizedBox(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: context.watch<DataProvider>().search,
                  style: Theme.of(context).textTheme.bodyText1,
                  onChanged: (value) =>
                      context.read<DataProvider>().filterSearch(context),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor, width: 1)),
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.search, color: primaryColor),
                  ),
                  suffix: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<DataProvider>().clearSearch();
                      },
                      icon: const Icon(Icons.clear, color: primaryColor)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 40,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => FilterButton(index: index),
                ),
              ),
              const Divider(
                color: Colors.black45,
                endIndent: 12,
                indent: 12,
                thickness: 1,
              ),
              dataWatch.isLoawding
                  ? SizedBox(
                      height: size.height * 0.7,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: primaryColor.withOpacity(0.7)),
                      ),
                    )
                  : Column(
                      children: [
                        ...dataWatch.filtredNews
                            .map((data) => NewsCard(
                                  data: data,
                                ))
                            .toList(),
                        Visibility(
                            visible: context.watch<DataProvider>().isOffset,
                            child: SizedBox(
                              height: 60,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor.withOpacity(0.7)),
                              ),
                            ))
                      ],
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
