import 'package:flutter/material.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/models/news.dart';
import 'package:taranis/views/news/news_details.dart';

class NewsCard extends StatelessWidget {
  final News data;
  const NewsCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NewsDetails(data: data))),
        child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Text(
                    data.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.blueGrey, fontSize: 20),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Source : ${data.source}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.black54, fontSize: 15),
                            )),
                        SizedBox(
                            child: Text(
                          data.date,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.black54, fontSize: 15),
                        )),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tags : ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.black54, fontSize: 20),
                      ),
                      SizedBox(
                          width: size.width * 0.8,
                          child: Wrap(
                            children: data.tags
                                .map((tag) => Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: secondColor.withOpacity(0.9)),
                                      child: Text(
                                        tag,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                      ),
                                    ))
                                .toList(),
                          ))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
