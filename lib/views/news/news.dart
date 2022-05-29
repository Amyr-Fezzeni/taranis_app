import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/widgets/news/news_card.dart';

import '../../providers/data_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().getAllNews();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if(!context.read<DataProvider>().isOffset) 
        {
          context.read<DataProvider>().loadMoreNews();
          }
      }
    });
  }

  Future<void> _refrech() async {
    context.read<DataProvider>().getAllNews();
    return;
  }

  @override
  Widget build(BuildContext context) {
    var dataWatch = context.watch<DataProvider>();
    var size = MediaQuery.of(context).size;
    return Container(
        color: bgColor,
        child: Center(
            child: Container(
                color: bgColor,
                child: RefreshIndicator(
                  onRefresh: _refrech,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    child: dataWatch.isLoawding
                        ? SizedBox(
                            height: size.height * 0.5,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor.withOpacity(0.7)),
                            ),
                          )
                        : SizedBox(
                            child: Column(children: [
                              ...dataWatch.allNews
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
                            ]),
                          ),
                  ),
                ))));
  }
}
