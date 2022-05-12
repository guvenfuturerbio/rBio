import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'order_summary_vm.dart';

class OrderSummaryScreen extends StatefulWidget {
  String? subCategoryId;
  String? categoryName;

  OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late ExpandableController _expandableController;
  int selectedPacket = 0;

  @override
  void initState() {
    _expandableController = ExpandableController();
    super.initState();
  }

  @override
  void dispose() {
    _expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.subCategoryId = Atom.queryParameters['subCategoryId'];
      widget.categoryName = Atom.queryParameters['categoryName'];
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<OrderSummaryScreenVm>(
      create: (context) => OrderSummaryScreenVm(context, widget.subCategoryId),
      child: Consumer<OrderSummaryScreenVm>(
        builder: (
          BuildContext context,
          OrderSummaryScreenVm value,
          Widget? child,
        ) {
          selectedPacket = value.selectedIndex ?? 0;

          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        widget.categoryName ?? "-",
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderSummaryScreenVm value) {
    switch (value.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Material(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
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
                                value.selectedItem!.title ?? "",
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.xHeadline3.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            expanded: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.subCategoryItems!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return index == value.selectedIndex
                                    ? GestureDetector(
                                        onTap: () {
                                          value.setSelectedIndex(index);
                                        },
                                        child: ListTile(
                                          title: Text(
                                            value.subCategoryItems![index]
                                                    .title ??
                                                "No title",
                                            style: context.xHeadline3.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          _expandableController.toggle();
                                          value.setSelectedItem(
                                              value.subCategoryItems![index]);
                                          value.setSelectedIndex(index);
                                        },
                                        child: ListTile(
                                          title: Text(
                                            value.subCategoryItems![index]
                                                    .title ??
                                                "No title",
                                            style: context.xHeadline4,
                                          ),
                                        ),
                                      );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 15,
                ),

                //
                Material(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
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
                        const Divider(),

                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value.selectedItem!.text!,
                            style: context.xHeadline4,
                          ),
                        ),

                        //
                        Visibility(
                          visible:
                              value.selectedItem!.url != null ? true : false,
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

                //
                const SizedBox(
                  height: 15,
                ),

                //
                Material(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: R.sizes.borderRadiusCircular,
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
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                value.selectedItem!.title ?? "-",
                                style: context.xHeadline4,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              (value.selectedItem!.price ?? "-") + " TL",
                              style: context.xHeadline4,
                            ),
                          ],
                        ),
                        const Divider(),
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
                              (value.selectedItem!.price ?? "-") + " TL",
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
                const SizedBox(
                  height: 15,
                ),

                //
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Utils.instance.button(
                    width: 260,
                    text: LocaleProvider.current.payment,
                    onPressed: () {
                      getIt<FirebaseAnalyticsManager>().logEvent(
                          UrunOdemesiTiklandiEvent(
                              value.selectedItem!.title ?? ''));
                      Atom.to(
                        PagePaths.creditCard,
                        queryParameters: {
                          'paymentType':
                              PaymentType.package.xGetIndex.toString(),
                          'paymentObjectCode':
                              (value.selectedItem!.id ?? widget.subCategoryId)
                                  .toString(),
                          'packageName':
                              Uri.encodeFull(value.selectedItem!.title ?? "-"),
                          'price': value.selectedItem!.price ?? 0.toString(),
                        },
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

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
