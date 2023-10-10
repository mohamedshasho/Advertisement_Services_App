import 'package:auth/pages/example.dart';
import 'package:auth/providers/ADsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ADsExamplesScreen extends StatelessWidget {
  static const String id = 'ADsExamplesScreen';
  const ADsExamplesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: Center(
        child: Consumer<AdsProvider>(
          builder: (ctx, data, _) {
            return Column(
              children: [
                Text(getTranslated(context, "Choose_type_of_your_AD")),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                SizedBox(
                  width: width * 0.8,
                  height: height * 0.3,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Example.id,
                          arguments: getTranslated(context, "billboard"));
                    },
                    child: Stack(children: [
                      Card(
                        child: Image.asset(
                          'assets/images/mmm.jpg',
                          width: width * 0.8,
                          height: height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        elevation: 10,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          // width: 300,
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Text(
                            getTranslated(context, "billboard"),
                            style: const TextStyle(
                                fontSize: 26, color: AppColors.textColorWhite),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                SizedBox(
                  width: width * 0.8,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Example.id,
                          arguments: getTranslated(context, "media"));
                    },
                    child: Stack(children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          'assets/images/4.png',
                          width: width * 0.8,
                          height: height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        elevation: 10,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          // width: 300,
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Text(
                            getTranslated(context, "media"),
                            style:const TextStyle(fontSize: 26, color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
