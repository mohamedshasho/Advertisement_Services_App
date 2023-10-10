import 'package:auth/model/Billboard.dart';
import 'package:auth/model/SelectBillboard.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CardBillboard extends StatelessWidget {
  final Billboard billboard;
  final BoxConstraints constraints;
  final TextEditingController textEditingController;

  const CardBillboard(this.billboard, this.constraints,this.textEditingController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("sssssssss");
    double price = 0;
    if (billboard.discount != null) {
      price =billboard.price! -
          (billboard.price! * billboard.discount! / 100);
    }
    return SizedBox(
      width: constraints.maxWidth * 0.8,
      height: constraints.maxHeight,
      child: Card(
        // color: AppColors.cardColor,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: '$apiImage${billboard.picture}',
                fit: BoxFit.fill,
                height: constraints.maxHeight * 0.4,
                width: constraints.maxWidth,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>  Image.asset('assets/images/5.png'),
              ),
            ),
            ListTile(
              title: Text(getTranslated(context, 'size')),
              subtitle: Text('${billboard.measurementsName}'),
              leading: Image.asset(
                "assets/images/measure.png",
                height: 32,
                width: 32,
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(getTranslated(context, 'measurement') +
                  '(' +
                  getTranslated(context, 'height') +
                  '*' +
                  getTranslated(context, 'width') +
                  ')'),
              subtitle: Text(
                  '(${billboard.measurementsHeight})*(${billboard.measurementsWidth})'),
              leading: Image.asset(
                "assets/images/square_measurement.png",
                height: 32,
                width: 32,
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(getTranslated(context, 'price')),
              subtitle: billboard.discount == null
                  ? Text(' ${billboard.price} ')
                  : Row(
                      children: [
                        Text(
                          ' ${billboard.price} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(' $price ')
                      ],
                    ),
              leading: Image.asset(
                "assets/images/price_tag.png",
                height: 32,
                width: 32,
              ),
            ),
            Consumer<AdsProvider>(
              builder: (ctx, ads, _) {
                SelectBillboard? selected =
                    ads.isBillboardAdded(billboard.id!);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (selected != null) {
                          ads.cancelBillboard(billboard.id!);
                        } else {
                          ads.selectBillboard(billboard.id!);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.buttonColor),
                      ),
                      child: Text(selected != null
                          ? getTranslated(context, 'cancel')
                          : getTranslated(context, 'select'),
                        style:const TextStyle(
                        color: AppColors.textColorBlack,
                      ),),
                    ),
                    const SizedBox(width: 10),
                    selected != null
                        ? Row(
                            children: [
                              InkWell(
                                child: const Icon(Icons.add),
                                onTap: () {
                                  ads.plusBillboard(billboard.id!);
                                  textEditingController.text =
                                      (int.parse(textEditingController.text) +
                                              1)
                                          .toString();

                                },
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: constraints.maxWidth * 0.2,
                                height: constraints.maxHeight * 0.07,
                                child: TextFormField(
                                  controller: textEditingController,
                                  textAlign: TextAlign.center,
                                  onChanged: (v) {
                                    try {
                                      selected.num = int.parse(v);
                                    } catch (e) {}
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: AppColors.assentColor),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                child: const Icon(Icons.remove),
                                onTap: () {
                                  if (selected.num > 1) {
                                    textEditingController.text =
                                        (int.parse(textEditingController.text) -
                                            1)
                                            .toString();
                                  }
                                  ads.minusBillboard(billboard.id!);
                                },
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
