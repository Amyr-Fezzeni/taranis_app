import 'package:flutter/material.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/models/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  final News data;
  const NewsDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "News details",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.data.link,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (value) {},
            onWebViewCreated: (controller) {
              this.controller = controller;
              setState(() {
                isLoading = false;
              });
            },
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              height: size.height,
              width: size.width,
              color: bgColor,
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
