import 'package:auth/constants.dart';
import 'package:auth/model/Response.dart';
import 'package:auth/model/user.dart';
import 'package:auth/pages/sign_up.dart';
import 'package:auth/providers/AuthProvider.dart';
import 'package:auth/providers/DrawerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const String id = 'Login';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User();

    final formState = GlobalKey<FormState>();
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (ctx, auth, _) {
          if (auth.user != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<DrawerProvider>().changePage(0);
              Navigator.pop(context);
            });
          }
          return Form(
            key: formState,
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person, color: AppColors.iconColor),
                      hintText: getTranslated(context, "phone"),
                      labelText: getTranslated(context, "phone"),
                    ),
                    onSaved: (String? value) {
                      user.phone = value;
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return getTranslated(context, "required");
                      }
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon:const Icon(
                        Icons.password,
                        color: AppColors.iconColor,
                      ),
                      hintText: getTranslated(context, "enter_your_password"),
                      labelText: getTranslated(context, "password"),
                    ),
                    onSaved: (String? value) {
                      user.password = value;
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return getTranslated(context, "required");
                      }
                    },
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.buttonColor),
                      ),
                      clipBehavior: Clip.hardEdge,
                      onPressed: () async {
                        var form = formState.currentState!;
                        if (formState.currentState!.validate()) {
                          form.save();
                          Response isLogin = await auth.login(user);
                          if (!isLogin.status!) {
                            showMessage(context, isLogin.message!);
                          }
                        }
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      Text(
                        getTranslated(context, "Don't_have_an_account_yet_?"),
                        style:const TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.id);
                        },
                        child: Text(getTranslated(context, "Create_account"),
                            style:const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  showMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        elevation: 5,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }
}
