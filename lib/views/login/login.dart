import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/data.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/providers/menu_provider.dart';
import 'package:taranis/services/shared_data.dart';
import 'package:taranis/views/home/home.dart';
import 'package:taranis/views/login/signup.dart';
import 'package:taranis/widgets/login/popup.dart';

import '../../providers/user_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  TextEditingController phoneLogin = TextEditingController(text: DataPrefrences.getLogin());
  FocusNode phoneFocusLogin = FocusNode();

  TextEditingController passwordLogin =
      TextEditingController(text: DataPrefrences.getPassword());
  FocusNode passwordFocusLogin = FocusNode();
  bool isObscureLogin = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 100)).then((value) => 
    context.read<MenuProvider>().updateCurrentPage(0)

    );
    FlutterNativeSplash.remove();
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: bgColor,
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 150,
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Text(
                  "Hello There,\nWelcome Back".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              child: Text("Sign in to continue"),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: phoneLogin,
                    validator: (value) {
                      return value.toString().length != 8
                          ? 'Phone number is not valid'
                          : null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
                    decoration: InputDecoration(
                        focusColor: primaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 25),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 20, color: Colors.grey),
                        
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: primaryColor, width: 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: phoneFocusLogin.hasFocus
                              ? primaryColor
                              : Colors.grey,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: " Phone Number "),
                    focusNode: phoneFocusLogin,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordLogin,
                    validator: (value) {
                      return passwordLogin.text.toString().isEmpty
                          ? "Password is empty"
                          : null;
                    },
                    obscureText: isObscureLogin,
                    decoration: InputDecoration(
                        focusColor: primaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 25),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1)),
                        fillColor: bgColor,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: passwordFocusLogin.hasFocus
                              ? primaryColor
                              : Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: primaryColor, width: 1)),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 20, color: Colors.grey),
                        hintText: 'Password',
                        suffixIcon: InkWell(
                          onTap: () =>
                              setState(() => isObscureLogin = !isObscureLogin),
                          child: Icon(
                            !isObscureLogin
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: ' Password '),
                    focusNode: passwordFocusLogin,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                child: context.watch<UserProvider>().isLoading
                    ? const SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Login".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white, fontSize: 20),
                      ),
                onPressed: () async {
                  if (context.read<UserProvider>().isLoading) return;
                  if (formGlobalKey.currentState!.validate()) {
                    var result = await context
                        .read<UserProvider>()
                        .login(phoneLogin.text, passwordLogin.text);
                    log(result.toString());
                    if (result != "true") {
                      await PopUp.showMyDialogAlert(context, result, "Ok");
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New user? ".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 18),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: Text(
                            "Sign up".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: primaryColor, fontSize: 18),
                          )),
                    ],
                  )),
            )
          ]),
        ),
      ),
    ));
  }
}
