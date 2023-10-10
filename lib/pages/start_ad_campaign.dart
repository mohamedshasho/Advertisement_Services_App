import 'package:auth/constants.dart';
import 'package:auth/pages/select_ads_details.dart';
import 'package:auth/pages/login_page.dart';
import 'package:auth/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class StartAdCampaign extends StatefulWidget {
  static const String id = "StartAdCampaign";

  const StartAdCampaign({Key? key}) : super(key: key);

  @override
  _StartAdCampaignState createState() => _StartAdCampaignState();
}

class _StartAdCampaignState extends State<StartAdCampaign> {
  DateTimeRange? _selectedDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _dataPicker() async {
    DateTimeRange? newDataRange = await showDateRangePicker(
        context: context,
        saveText: getTranslated(context, "Save"),
        locale: const Locale('ar', ''),
        // or remove this , by default ar if phone is Arabic
        helpText: getTranslated(context, "select_date"),
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2024),
        currentDate: DateTime.now());
    if (newDataRange == null) return;
    setState(() => _selectedDate = newDataRange);
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthProvider>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(getTranslated(context, "order"),
              style: TextStyle(
                color: AppColors.textColorBlack,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: Text(
                  getTranslated(context, "select_date"),
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                alignment: Alignment.topRight,
                child: Text(
                  getTranslated(context,
                      'please_select_the_begin_and_end_of_your_AD_but_at_least_14_days'),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 20,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Icon(
                        Icons.date_range,
                        size: 100,
                        color: AppColors.iconColor,
                      ),
                      //const Text('اضغط لاختيار مدة حملتك الاعلانية '),
                      _selectedDate == null
                          ? ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.buttonColor),
                              ),
                              onPressed: _dataPicker,
                              child: Text(
                                getTranslated(
                                    context, "press_to_chose_the_duration"),
                                style: const TextStyle(
                                    color: AppColors.textColorBlack),
                              ))
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.buttonColor),
                                      ),
                                      onPressed: _dataPicker,
                                      child: Text(
                                        _selectedDate!.start
                                            .toString()
                                            .split(" ")
                                            .first,
                                        style: const TextStyle(
                                            color: AppColors.textColorBlack),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text("to"),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.buttonColor),
                                        ),
                                        onPressed: _dataPicker,
                                        child: Text(
                                          _selectedDate!.end
                                              .toString()
                                              .split(" ")
                                              .first,
                                          style:const TextStyle(
                                              color: AppColors.textColorBlack),
                                        ))
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 30)),
                                Text('${_selectedDate!.duration.inDays} ' +
                                    getTranslated(context, 'days')),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(700),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.buttonColor),
                    ),
                    onPressed: () {
                      if (_selectedDate == null ||
                          _selectedDate!.duration.inDays < 14) {
                        showMessage(
                            context,
                            getTranslated(
                                context, "duration_should_be_14_day_and_more"));

                        return;
                      }
                      if (auth.user == null) {
                        showMessage(context,
                            getTranslated(context, "Should_login_firstly"));
                        Navigator.pushNamed(
                          context,
                          Login.id,
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          SelectAdsDetails.id,
                          arguments: [
                            _selectedDate!.start.toString().split(" ").first,
                            _selectedDate!.end.toString().split(" ").first,
                          ],
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.darkPrimaryColor,
                    ),
                  ))
            ],
          ),
        ));
  }

  showMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.errorColor,
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
