import 'package:auth/constants.dart';
import 'package:auth/model/user.dart';
import 'package:auth/pages/login_page.dart';
import 'package:auth/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'Signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User();
    final _passwordController = TextEditingController();
    var auth = context.read<AuthProvider>();
    // AuthProvider authProvider =
    //     Provider.of<AuthProvider>(context, listen: false);
    final formState1 = GlobalKey<FormState>();
    return Scaffold(
        body: Center(
      child: Form(
        key: formState1,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                width: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo_dark.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "What_do_people_call_you?"),
                  labelText: getTranslated(context, "Full_Name"),
                ),
                onSaved: (String? value) {
                  user.fullName = value;
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
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "What_do_people_call_you?"),
                  labelText: getTranslated(context, "User_Name"),
                ),
                onSaved: (String? value) {
                  user.username = value;
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return getTranslated(context, "required");
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "enter_your_number"),
                  labelText: getTranslated(context, "Number"),
                ),
                onSaved: (String? value) {
                  user.phone = value;
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return getTranslated(context, "required");
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.business,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "enter_your_Company_Name"),
                  labelText: getTranslated(context, "Company"),
                ),
                onSaved: (String? value) {
                  user.companyName = value;
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
                  icon: const Icon(
                    Icons.password,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "enter_your_password"),
                  labelText: getTranslated(context, "password"),
                ),
                onSaved: (String? value) {
                  user.password = value;
                },
                controller: _passwordController,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return getTranslated(context, "required");
                  }
                },
              ),
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.password,
                      color: AppColors.iconColor,
                    ),
                    hintText: getTranslated(context, "confirm_your_password"),
                    labelText: getTranslated(context, "confirm_password"),
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value != _passwordController.text) {
                      return getTranslated(context, "password_don't_match");
                    }
                    return null;
                  }),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.monitor,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "Enter_your_Job_Name"),
                  labelText: getTranslated(context, "Job_Name"),
                ),
                onSaved: (String? value) {
                  user.jobName = value;
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return getTranslated(context, "required");
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.location_city,
                    color: AppColors.iconColor,
                  ),
                  hintText: getTranslated(context, "Enter_your_City"),
                  labelText: getTranslated(context, "City"),
                ),
                onSaved: (String? value) {
                  user.city = value;
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
                  onPressed: () {
                    var form = formState1.currentState!;
                    if (form.validate()) {
                      form.save();

                      auth.register(user);
                    }
                  },
                  child: Text(getTranslated(context, "Create_account"))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    getTranslated(context, "Have_an_account_already?"),
                    style: const TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Login.id);
                    },
                    child: Text(getTranslated(context, "login"),
                        style: const TextStyle(
                            fontSize: 25,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
