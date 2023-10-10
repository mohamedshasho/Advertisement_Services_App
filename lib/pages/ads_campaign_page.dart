import 'package:auth/model/AdCampaign.dart';
import 'package:auth/providers/AdsCampiagnProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class ADsCampaignScreen extends StatefulWidget {
  static const String id = "adscampaign";
  const ADsCampaignScreen({Key? key}) : super(key: key);
  @override
  State<ADsCampaignScreen> createState() => _ADsCampaignScreenState();
}

class _ADsCampaignScreenState extends State<ADsCampaignScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdsCampaignProvider>().getAdsCampaign();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<AdsCampaignProvider>(
      builder: (ctx, ads, _) {
        if (ads.adCampaigns==null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<AdCampaign> adCampaigns= ads.adCampaigns!;
        return RefreshIndicator(
          onRefresh: () async {
            ads.getAdsCampaign();
          },
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              return _adsCard(adCampaigns[index], height, width);
            },
            separatorBuilder: (_, index) {
              return const Divider();
            },
            itemCount: adCampaigns.length,
          ),
        );
      },
    );
  }

  Card _adsCard(AdCampaign ad, double height, double width) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: height * 0.01),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ad.picture != null
                ?

            CachedNetworkImage(
              imageUrl: "$apiImage${ad.picture}",
              height: height * 0.2,
              width: width * 0.4,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset('assets/images/wait.png'),
            )
                : Image.asset(
                    'assets/images/wait.png',
                    height: height * 0.2,
                    width: width * 0.4,
                    fit: BoxFit.fill,
                  ),
            SizedBox(width: width * 0.01),
            SizedBox(
              width: width * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowCard(getTranslated(context, "state"), ad.state!),
                  SizedBox(height: height * 0.01),
                  _rowCard(getTranslated(context, "Publication_start_date"),
                      ad.startDate!.split(' ').first),
                  SizedBox(height: height * 0.01),
                  _rowCard(getTranslated(context, "Publication_end_date"),
                      ad.endDate!.split(' ').first),
                  SizedBox(height: height * 0.01),
                  _rowCard(
                      getTranslated(context, "Payment_type"), ad.priceType!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _rowCard(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(label)),
        const SizedBox(width: 5),
        Flexible(child: Text(value)),
      ],
    );
  }
}
