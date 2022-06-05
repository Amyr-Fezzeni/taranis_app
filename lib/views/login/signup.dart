import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taranis/constants/data.dart';
import 'package:taranis/constants/style.dart';
import 'package:taranis/models/user.dart';
import 'package:taranis/providers/user_provider.dart';
import 'package:taranis/views/home/home.dart';
import 'package:taranis/views/login/login.dart';
import 'package:taranis/widgets/login/popup.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formGlobalKey = GlobalKey<FormState>();
  bool isValid = true;

  TextEditingController fullNameSignup = TextEditingController();
  FocusNode fullNameFocusSignup = FocusNode();

  TextEditingController emailSignup = TextEditingController();
  FocusNode emailFocusSignup = FocusNode();

  TextEditingController phoneSignup = TextEditingController();
  FocusNode phoneFocusSignup = FocusNode();

  TextEditingController passwordSignup = TextEditingController();
  FocusNode passwordFocusSignup = FocusNode();
  bool isObscureSignup = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
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
                alignment: Alignment.center,
                child: SizedBox(
                  child: Text(
                    "Welcome".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                child: Text("Sign up to create account"),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameSignup,
                      validator: (value) {
                        return value.toString().length < 5
                            ? 'Full name should be at least 5 character'
                            : null;
                      },
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: fullNameFocusSignup.hasFocus
                                ? primaryColor
                                : Colors.grey,
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: " Full name "),
                      focusNode: fullNameFocusSignup,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailSignup,
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value ?? " ");
                        return !emailValid ? 'Email is not valid' : null;
                      },
                      keyboardType: TextInputType.emailAddress,
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1)),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: emailFocusSignup.hasFocus
                                ? primaryColor
                                : Colors.grey,
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: " Email "),
                      focusNode: emailFocusSignup,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneSignup,
                      validator: (value) {
                        return value.toString().length != 8
                            ? 'Phone number not valid'
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
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1)),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: phoneFocusSignup.hasFocus
                                ? primaryColor
                                : Colors.grey,
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: " Phone Number "),
                      focusNode: phoneFocusSignup,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordSignup,
                      onChanged: (value) {
                        setState(() {
                          isValid =
                              formGlobalKey.currentState?.validate() == false;
                        });
                      },
                      validator: (value) {
                        String msg = "Password must include:\n";

                        msg += !RegExp(r'^(?=.*?[A-Z])').hasMatch(value ?? "")
                            ? "An uppercase character\n"
                            : "";
                        msg += !RegExp(r'^(?=.*?[a-z])').hasMatch(value ?? "")
                            ? "A lowercase character\n"
                            : "";
                        msg += !RegExp(r'^(?=.*?[0-9])').hasMatch(value ?? "")
                            ? "A numeric character\n"
                            : "";
                        msg +=
                            !RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value ?? "")
                                ? r"A special character (!@#\$&*~)" "\n"
                                : "";
                        msg += value.toString().length < 8
                            ? "A minimum of 8 character"
                            : "";

                        String pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        var result = RegExp(pattern).hasMatch(value ?? "");
                        log(result.toString());

                        return !result ? msg : null;
                      },
                      obscureText: isObscureSignup,
                      decoration: InputDecoration(
                          focusColor: primaryColor,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 25),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1)),
                          fillColor: bgColor,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: passwordFocusSignup.hasFocus
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
                            onTap: () => setState(
                                () => isObscureSignup = !isObscureSignup),
                            child: Icon(
                              !isObscureSignup
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: ' Password '),
                      focusNode: passwordFocusSignup,
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
                          "Register".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white, fontSize: 20),
                        ),
                  onPressed: () async {
                    if (context.read<UserProvider>().isLoading) return;
                    if (formGlobalKey.currentState!.validate()) {
                      User user = User(
                          id: "",
                          fullName: fullNameSignup.text,
                          email: emailSignup.text,
                          phoneNumber: int.parse(phoneSignup.text),
                          password: passwordSignup.text);
                      var result =
                          await context.read<UserProvider>().signUpUser(user);

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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account? ".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 18),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: Text(
                              "login".toUpperCase(),
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
      ),
    );
  }
}
