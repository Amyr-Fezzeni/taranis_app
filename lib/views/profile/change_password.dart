import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/providers/user_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    var pass = context.watch<UserProvider>();
    var size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 1 : 0.7,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Change password".toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              child: Icon(
                Icons.lock,
                color: primaryColor,
                size: 150,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "Old password : ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.55,
                  height: 40,
                  child: CupertinoTextField(
                    controller: pass.oldPassword,
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: pass.isObscureOld,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1)),
                    suffix: IconButton(
                        onPressed: () =>
                            context.read<UserProvider>().changeOldVisibility(),
                        icon: Icon(
                          !pass.isObscureOld
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "New password : ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.55,
                  height: 40,
                  child: CupertinoTextField(
                    controller: pass.newPassword,
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: pass.isObscure,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1)),
                    suffix: IconButton(
                        onPressed: () =>
                            context.read<UserProvider>().changePassVisibility(),
                        icon: Icon(
                          !pass.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "Confirm new password : ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.55,
                  height: 40,
                  child: CupertinoTextField(
                    controller: pass.newPasswordConfirmed,
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: pass.isObscureConfirmed,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1)),
                    suffix: IconButton(
                        onPressed: () => context
                            .read<UserProvider>()
                            .changeConfPassVisibility(),
                        icon: Icon(
                          !pass.isObscureConfirmed
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  onPressed: () =>
                      context.read<UserProvider>().validator(context),
                  child: SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        "Change password",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: bgColor),
                      ),
                    ),
                  )),
            )
          ],
        )),
      ),
    );
  }
}
