import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'shopping_cart_vm.dart';

part 'widget/quntity_dropdown.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int selectedPacket = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingCartScreenVm>(
      create: (context) => ShoppingCartScreenVm(context),
      child: Consumer<ShoppingCartScreenVm>(
        builder:
            (BuildContext context, ShoppingCartScreenVm value, Widget? child) {
          return RbioScaffold(
            appbar: RbioAppBar(
              context: context,
              title: RbioAppBar.textTitle(context, "Shopping Cart"),
            ),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ShoppingCartScreenVm value) {
    switch (value.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();
      case LoadingProgress.done:
        return SingleChildScrollView(
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
                : const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleProvider.current.fee_information,
                                style: context.xHeadline3
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const Divider(),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          "Covid test",
                                          style: TextStyle(),
                                          maxLines: 2,
                                        ),
                                      ),

                                      //
                                      Row(
                                        children: [
                                          //
                                          const QuantityDropdown(),

                                          //
                                          const SizedBox(
                                            width: 8,
                                          ),

                                          //
                                          Utils.instance.button(
                                              context: context,
                                              text: "Delete",
                                              width: 30,
                                              height: 12,
                                              onPressed: () {
                                                LoggerUtils.instance
                                                    .i("Delete worked");
                                              }),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(("200") + " TL",
                                          style: TextStyle()),
                                    ],
                                  );
                                }),
                          ])),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleProvider.current.total,
                        style: context.xHeadline3
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(("0") + " TL",
                        style: context.xHeadline3
                            .copyWith(fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Utils.instance.button(
                    context: context,
                    width: 260,
                    text: LocaleProvider.current.payment,
                    onPressed: () {},
                  ),
                ),
                Text(
                  LocaleProvider.current.called_by_our_hospital,
                  textAlign: TextAlign.center,
                  style:
                      context.xHeadline3.copyWith(fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        );
      case LoadingProgress.error:
        return const Center(
          child: Text("Error!"),
        );
      default:
        return const SizedBox();
    }
  }
}
