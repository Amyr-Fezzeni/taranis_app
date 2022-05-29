import 'package:flutter/material.dart';
import 'package:taranis/constants/style.dart';

class PopUp {
  static Future<void> showMyDialog(
      dynamic context, String msg, btn1, btn2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              AlertDialog(
                backgroundColor: bgColor,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(msg, style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 70,
                      height: 40,
                      child: Center(
                        child: Text(btn1,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 70,
                      height: 40,
                      child: Center(
                        child: Text(btn2,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showMyDialogAlert(
      dynamic context, String msg, btn) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              AlertDialog(
                backgroundColor: bgColor,
                content: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(msg, style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      width: 60,
                      height: 40,
                      child: Center(
                        child: Text(btn,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.white)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
