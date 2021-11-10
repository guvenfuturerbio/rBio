import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../features/store/quntitydropdown_widget.dart';
import 'shopping_cart_vm.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key key}) : super(key: key);

  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  ExpandableController _expandableController = ExpandableController();
  int selectedPacket = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingCartScreenVm>(
      create: (context) => ShoppingCartScreenVm(context),
      child: Consumer<ShoppingCartScreenVm>(
        builder:
            (BuildContext context, ShoppingCartScreenVm value, Widget child) {
          return Scaffold(
              appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(title: "Shopping Cart"),
                leading: ButtonBackWhite(context),
              ),
              body: value.progress == LoadingProgress.LOADING
                  ? RbioLoading()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: kIsWeb
                            ? EdgeInsets.only(
                                top: 50,
                                left: Atom.size.width < 800
                                    ? Atom.size.width * 0.03
                                    : Atom.size.width * 0.10,
                                right: Atom.size.width < 800
                                    ? Atom.size.width * 0.03
                                    : Atom.size.width * 0.10)
                            : EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Material(
                              clipBehavior: Clip.antiAlias,
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            LocaleProvider
                                                .current.fee_information,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        Divider(),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "Covid test",
                                                      style: TextStyle(),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      QuantityDropdownWidget(),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      button(
                                                          text: "Delete",
                                                          width: 30,
                                                          height: 12),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(("200") + " TL",
                                                      style: TextStyle()),
                                                ],
                                              );
                                            }),
                                      ])),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleProvider.current.total,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(("sdasd" ?? "-") + " TL",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: button(
                                  width: 260,
                                  text: LocaleProvider.current.payment,
                                  onPressed: () {}),
                            ),
                            Text(
                              LocaleProvider.current.called_by_our_hospital,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }
}
