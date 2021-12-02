import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'order_summary_vm.dart';

class OrderSummaryScreen extends StatefulWidget {
  var subCategoryId;
  var categoryName;

  OrderSummaryScreen({
    Key key,
    this.subCategoryId,
    this.categoryName,
  }) : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  ExpandableController _expandableController = ExpandableController();
  int selectedPacket = 0;

  @override
  Widget build(BuildContext context) {
    try {
      widget.subCategoryId = Atom.queryParameters['subCategoryId'];
      widget.categoryName = Atom.queryParameters['categoryName'];
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<OrderSummaryScreenVm>(
      create: (context) => OrderSummaryScreenVm(context, widget.subCategoryId),
      child: Consumer<OrderSummaryScreenVm>(
        builder: (context, value, child) {
          selectedPacket = value.selectedIndex;
          return RbioScaffold(
              appbar: RbioAppBar(
                title: TitleAppBarWhite(title: widget.categoryName ?? "-"),
              ),
              body: value.progress == LoadingProgress.LOADING
                  ? RbioLoading()
                  : _buildBody(context, value));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderSummaryScreenVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpandablePanel(
                                controller: _expandableController,
                                header: Text(
                                  LocaleProvider.current.select_package,
                                  style: context.xHeadline3.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                collapsed: ListTile(
                                  title: Text(
                                    value?.selectedItem?.title ?? "",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.xHeadline3.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                expanded: Container(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: value.subCategoryItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index == value.selectedIndex
                                          ? GestureDetector(
                                              onTap: () {
                                                value.setSelectedIndex(index);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    value
                                                        .subCategoryItems[index]
                                                        .title,
                                                    style: context.xHeadline3
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ))
                                          : GestureDetector(
                                              onTap: () {
                                                _expandableController.toggle();
                                                value.setSelectedItem(value
                                                    .subCategoryItems[index]);
                                                value.setSelectedIndex(index);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  value.subCategoryItems[index]
                                                      .title,
                                                  style: context.xHeadline4,
                                                ),
                                              ));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: 15,
                ),

                //
                Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Text(
                            LocaleProvider.current.package_description,
                            style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          //
                          Divider(),

                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value.selectedItem.text,
                              style: context.xHeadline4,
                            ),
                          ),

                          //
                          Visibility(
                            visible:
                                value.selectedItem.url != null ? true : false,
                            child: Container(
                              alignment: Alignment.center,
                              child: Utils.instance.button(
                                text: LocaleProvider.current.package_detail,
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: 10,
                                onPressed: () {
                                  value.showWebViewPage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: 15,
                ),

                //
                Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleProvider.current.fee_information,
                          style: context.xHeadline3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                value?.selectedItem?.title ?? "-",
                                style: context.xHeadline4,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              (value?.selectedItem?.price ?? "-") + " TL",
                              style: context.xHeadline4,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleProvider.current.total,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              (value?.selectedItem?.price ?? "-") + " TL",
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: 15,
                ),

                //
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Utils.instance.button(
                    width: 260,
                    text: LocaleProvider.current.payment,
                    onPressed: () {
                      Atom.to(
                        PagePaths.CREDIT_CARD,
                        queryParameters: {
                          'paymentType':
                              PaymentType.PACKAGE.xGetIndex.toString(),
                          'paymentObjectCode':
                              (value?.selectedItem?.id ?? widget.subCategoryId)
                                  .toString(),
                          'packageName':
                              Uri.encodeFull(value?.selectedItem?.title ?? "-"),
                          'price': value?.selectedItem?.price ?? 0.toString(),
                        },
                      );

                      AnalyticsManager().sendEvent(
                        ItemPaymentClicked(
                          itemName: value.selectedItem.title,
                        ),
                      );
                    },
                  ),
                ),

                //
                Text(
                  LocaleProvider.current.called_by_our_hospital,
                  textAlign: TextAlign.center,
                  style: context.xHeadline3.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          ),
        );

      case LoadingProgress.ERROR:
        return Center(child: Text("Error!"));

      default:
        return SizedBox();
    }
  }
}
