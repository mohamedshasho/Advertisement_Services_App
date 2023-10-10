import 'package:auth/constants.dart';
import 'package:auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

class EditAccount extends StatefulWidget {
  static const String id = 'editAccount';

  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  var edit = false;
  String? fullName;
  String? phone;
  String? company;
  String? jobName;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          edit
              ? IconButton(
                  onPressed: () {
                    edit = !edit;
                    setState(() {});
                  },
                  icon: const Icon(Icons.done),
                )
              : IconButton(
                  onPressed: () {
                    edit = !edit;
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
        ],
        title: Text(getTranslated(context, 'Account_Setting')),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(builder: (context, auth, _) {
        User? user = auth.user;
        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        fullName = user.fullName;
        phone = user.phone;
        company = user.companyName;
        jobName = user.jobName;
        return Card(
          child: SizedBox(
            width: double.infinity,
            child: edit
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _rowCardEdit(
                        getTranslated(context, 'Full_Name') + ":",
                        user.fullName!,
                        (newValue) => {fullName = newValue},
                      ),
                      _rowCardEdit(
                        getTranslated(context, 'phone') + ":",
                        user.phone!,
                        (newValue) => {phone = newValue},
                      ),
                      _rowCardEdit(
                        getTranslated(context, 'Company') + ":",
                        user.companyName!,
                        (newValue) => {company = newValue},
                      ),
                      _rowCardEdit(
                        getTranslated(context, 'Job_Name') + ":",
                        user.jobName!,
                        (newValue) => {jobName = newValue},
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.buttonColor),
                          ),
                          onPressed: () {

                            auth.updateAccount(fullName,phone,company,jobName);
                          },
                          child: Text(
                            getTranslated(context, "Save"),
                            style: const TextStyle(
                                color: AppColors.textColorBlack),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _rowCard(getTranslated(context, 'Full_Name') + ":",
                          user.fullName!),
                      _rowCard(
                          getTranslated(context, 'phone') + ":", user.phone!),
                      _rowCard(getTranslated(context, 'Company') + ":",
                          user.companyName!),
                      _rowCard(getTranslated(context, 'Job_Name') + ":",
                          user.jobName!),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  Padding _rowCard(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(label)),
          const SizedBox(width: 5),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }

  Padding _rowCardEdit(
      String label, String value, Function(String v) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(label)),
          const SizedBox(width: 5),
          Flexible(
            child: TextFormField(
              initialValue: value,
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
