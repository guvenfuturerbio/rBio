import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../helper/loading_dialog.dart';
import '../../helper/resources.dart';
import '../../pages/home/home_page_view_model.dart';
import '../../widgets/utils.dart';
import 'premium_store_page.dart';

class PackageDetailPage extends StatefulWidget {
  final StorePackage storePackage;
  PackageDetailPage({this.storePackage});
  @override
  _PackageDetailPage createState() => _PackageDetailPage();
}

class _PackageDetailPage extends State<PackageDetailPage> {
  @override
  void initState() {
    super.initState();
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
                    onTap: () => Navigator.of(context).pop()),
                actions: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        print("go to cart!");
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        child: SvgPicture.asset(R.image.shoppingcart_icon),
                      ))
                ]),
            body: getMainBody(context),
          );
        },
      ),
    );
  }

  Widget getMainBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
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
                              child: Image.asset(widget.storePackage.image),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                  widget.storePackage.name ??
                                      LocaleProvider.current.unknown,
                                  style: TextStyle(fontSize: 15)),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child:
                                  Text("Price ₺${widget.storePackage.price}"),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ])),
              ),
            )),
        GestureDetector(
          onTap: () async {},
          child: Container(
              padding: EdgeInsets.only(left: 64, right: 64, top: 16),
              child: Card(
                color: Colors.grey,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  child: Center(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: R.regularBlue,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              child: Center(
                                  child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    child: Text("Monthly",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: R.color.white)),
                                  ),
                                )
                              ])),
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              child: Center(
                                  child: Column(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    child: Text("Annualy",
                                        style: TextStyle(
                                            fontSize: 15, color: R.color.grey)),
                                  ),
                                )
                              ])),
                            ),
                          )
                        ],
                      ),
                    )
                  ])),
                ),
              )),
        )
      ],
    );
  }
}
