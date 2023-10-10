import 'dart:io';

import 'package:auth/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/Contract.dart';
import '../providers/ContractProvider.dart';

class ContractScreen extends StatelessWidget {
  static const String id = "contractScreen";

  const ContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractProvider>(
      builder: (ctx, data, _) {
        if (data.contracts == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Contract> contracts = data.contracts!;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ContractProvider>().getContract();
            },
            child: ListView.separated(
                itemBuilder: (c,index) {
                  return _buildCard(context, contracts[index]);
                },
                separatorBuilder: (c,index) {
                  return const Divider();
                },
                itemCount: contracts.length),
          );
        }
      },
    );
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Card _buildCard(BuildContext context, Contract e) {
    return Card(
      color: AppColors.assentColor,
      child: Column(
        children: [
          buildItem(context, 'PID', e.id.toString()),
          buildItem(context, 'Costumer', e.costumer!),
          buildItem(context, 'Contract_type', e.contractType!),
          buildItem(context, 'Publication_start_date', e.startDate!),
          buildItem(context, 'Publication_end_date', e.endDate!),
          buildItem(context, 'price', e.price.toString()),
          buildItem(context, 'Discount', e.discount.toString()),
          buildItem(
              context, 'Total_Price', (e.price! - e.discount!).toString()),
          buildItem(context, 'Payment_type', e.priceType!),
          buildItem(context, 'Created_At', e.createdAt!),
          if (e.linkConfirmPay == null)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.darkPrimaryColor),
              ),
              child: Text(getTranslated(context, 'send_confirm_pay')),
              onPressed: () {
                getImage().then((value) {
                  if (value != null) {
                    context
                        .read<ContractProvider>()
                        .sendConfirmPay(value.path, e.id!)
                        .then((value) => showMessage(context, value));
                  }
                });
              },
            ),
        ],
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

  Padding buildItem(BuildContext context, String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              getTranslated(context, key) + ":",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
