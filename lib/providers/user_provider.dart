import 'package:flutter/material.dart';
import 'package:taranis/models/user.dart';
import 'package:taranis/services/shared_data.dart';
import 'package:taranis/services/user_service.dart';
import 'package:taranis/views/login/login.dart';
import 'package:taranis/widgets/login/popup.dart';

class UserProvider with ChangeNotifier {
  User? currentUser;
  bool isLoggedIn = false;
  bool isLoading = false;

  setUser(User user) {
    currentUser = user;
    DataPrefrences.setLogin(user.phoneNumber.toString());
    DataPrefrences.setPassword(user.password);
    notifyListeners();
  }

  Future<String> signUpUser(User user) async {
    isLoading = true;
    notifyListeners();
    var result = await UserService.addUser(user);
    if (result == "true") {
      User? u = await UserService.getUser(user.phoneNumber);
      if (u != null) {
        setUser(u);
      }
    }
    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<String> login(String phone, String password) async {
    isLoading = true;
    notifyListeners();
    User? user = await UserService.getUser(int.parse(phone));
    if (user != null) {
      if (user.password == password) {
        setUser(user);
        isLoggedIn = true;
        isLoading = false;
        notifyListeners();
        return "true";
      } else {
        isLoading = false;
        notifyListeners();
        return "Phone number or password incorrect";
      }
    } else {
      isLoading = false;
      notifyListeners();
      return "Phone number doesn't exist";
    }
  }

  logOut(BuildContext context) {
    isLoggedIn = false;
    currentUser = null;
    DataPrefrences.setPassword("");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  final oldPassword = TextEditingController(text: "");
  final newPassword = TextEditingController(text: "");
  final newPasswordConfirmed = TextEditingController(text: "");

  init() {
    oldPassword.text = "";
    newPassword.text = "";
    newPasswordConfirmed.text = "";
  }

  bool isObscureOld = true;
  changeOldVisibility() {
    isObscureOld = !isObscureOld;
    notifyListeners();
  }

  bool isObscure = true;
  changePassVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  bool isObscureConfirmed = true;
  changeConfPassVisibility() {
    isObscureConfirmed = !isObscureConfirmed;
    notifyListeners();
  }

  Future<void> validator(BuildContext context) async {
    if (newPasswordConfirmed.text.isEmpty || newPassword.text.isEmpty) {
      await PopUp.showMyDialogAlert(context, "All fields required.", "Ok");
    } else if (newPasswordConfirmed.text != newPassword.text) {
      await PopUp.showMyDialogAlert(
          context, "New paswords doesn't match.", "Ok");
    } else if (oldPassword.text != currentUser?.password) {
      await PopUp.showMyDialogAlert(context, "Old password incorrect.", "Ok");
    } else {
      currentUser?.password = newPassword.text;
      bool result = await UserService.changePassword(currentUser!);

      if (result) {
        await PopUp.showMyDialogAlert(
            context, "Password changed seccesfully.", "Ok");
      } else {
        await PopUp.showMyDialogAlert(
            context, "Connection error, please try again later", "Ok");
      }

      Navigator.pop(context);
    }
  }

  Future<void> validatorPhone(BuildContext context, String phone) async {
    if (phone.isEmpty) {
      await PopUp.showMyDialogAlert(context, "Phone number empty!", "Ok");
      return;
    }
    if (phone.length != 8) {
      await PopUp.showMyDialogAlert(context, "Phone number invalid!", "Ok");
      return;
    }
    if (phone == currentUser?.phoneNumber.toString()) {
      await PopUp.showMyDialogAlert(
          context, "You can't update the same phone number!", "Ok");
      return;
    }
    if (await UserService.checkExistingUser(int.parse(phone))) {
      await PopUp.showMyDialogAlert(
          context, "Phone number already existe!", "Ok");
      return;
    }
    currentUser?.phoneNumber = int.parse(phone);
    bool result = await UserService.changePhoneNumber(currentUser!);

    if (result) {
      await PopUp.showMyDialogAlert(
          context, "Phone number changed seccesfully.", "Ok");
      User? user = await UserService.getUser(currentUser!.phoneNumber);
      if (user != null) setUser(user);
      notifyListeners();
    } else {
      await PopUp.showMyDialogAlert(
          context, "Connection error, please try again later", "Ok");
    }

    Navigator.pop(context);
  }
}
