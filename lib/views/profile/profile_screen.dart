import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/providers/user_provider.dart';
import 'package:taranis/views/profile/change_password.dart';
import 'package:taranis/views/profile/change_phone_number.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: bgColor,
          child: Center(
              child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: primaryColor,
                radius: 95,
                child: CircleAvatar(
                  backgroundColor: bgColor,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                  radius: 90,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name :",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        user!.fullName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email :",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone number :",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) =>
                                    const ChangePhoneNumber());
                          },
                          child: Text(
                            context
                                .watch<UserProvider>()
                                .currentUser!
                                .phoneNumber
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: primaryColor),
                          )),
                    ],
                  ),
                ),
              ),
              // Card(
              //   color: bgColor,
              //   elevation: 3,
              //   child: Container(
              //     height: 50,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Dark mode :",
              //           style: Theme.of(context).textTheme.bodyText1,
              //         ),
              //         CupertinoSwitch(
              //             activeColor: provider.btnColor,
              //             value: provider.darkMode,
              //             onChanged: (value) => context
              //                 .read<AppProvider>()
              //                 .changeDarkMode(value)),
              //       ],
              //     ),
              //   ),
              // ),
              Card(
                color: bgColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password :",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => const ChangePassword());
                          },
                          child: Text(
                            "Change Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: primaryColor),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: primaryColor,
                elevation: 3,
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () =>
                              context.read<UserProvider>().logOut(context),
                          child: Text(
                            "Disconnect",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.white, fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
