import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../helper/loading_dialog.dart';
import '../../helper/resources.dart';
import '../../pages/home/home_page_view_model.dart';
import '../../widgets/utils.dart';
import 'package_detail_page.dart';

class PremiumStorePage extends StatefulWidget {
  PremiumStorePage();
  @override
  _PremiumStorePage createState() => _PremiumStorePage();
}

class _PremiumStorePage extends State<PremiumStorePage> {
  List<StorePackage> storePackages;
  @override
  void initState() {
    super.initState();
    storePackages = [];

    storePackages.add(new StorePackage(
        name: "Product 1", price: 90.45, image: R.image.accu_check_png));
    storePackages.add(new StorePackage(
        name: "Product 2", price: 100.45, image: R.image.contour_png));
    storePackages.add(new StorePackage(
        name: "Product 3",
        price: 130.45,
        image: R.image.omron_blood_pressure_wrist));
  }

  @override
  void dispose() {
    super.dispose();
  }

  LoadingDialog loadingDialog;

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Consumer<HomePageViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(title: LocaleProvider.current.store),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            body: getMainBody(context),
          );
        },
      ),
    );
  }

  Widget getMainBody(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: storePackages.length,
      itemBuilder: (context, index) {
        return discoveredDeviceContainer(context, storePackages[index]);
      },
    );
  }

  Widget discoveredDeviceContainer(
      BuildContext context, StorePackage storePackage) {
    return new GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (contextTrans) => PackageDetailPage(
                    storePackage: storePackage,
                  )),
        );
      },
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              child: Center(
                  child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(storePackage.image),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                storePackage.name ??
                                    LocaleProvider.current.unknown,
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(LocaleProvider.current.view_details,
                                style: TextStyle(
                                    fontSize: 15, color: R.color.grey)),
                          ),
                          Container(
                            height: 30,
                            width: 15,
                            padding: EdgeInsets.only(left: 8),
                            child: SvgPicture.asset(R.image.right_arrow),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])),
            ),
          )),
    );
  }
}

class StorePackage {
  String name;
  double price;
  String image;
  StorePackage({this.name, this.price, this.image});
}
