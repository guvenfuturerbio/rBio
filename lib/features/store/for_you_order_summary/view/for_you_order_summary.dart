import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../cubit/cubit.dart';

class ForYouOrderSummaryScreen extends StatelessWidget {
  String? subCategoryId;
  String? categoryName;

  ForYouOrderSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      subCategoryId = Atom.queryParameters['subCategoryId'];
      categoryName = Atom.queryParameters['categoryName'];
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider(
      create: (context) =>
          ForYouOrderSummaryCubit(getIt())..fetchAll(subCategoryId!),
      child: OrderSummaryView(subCategoryId, categoryName),
    );
  }
}

class OrderSummaryView extends StatefulWidget {
  String? subCategoryId;
  String? categoryName;
  OrderSummaryView(this.subCategoryId, this.categoryName, {Key? key})
      : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryView> {
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
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        widget.categoryName ?? "-",
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return BlocBuilder<ForYouOrderSummaryCubit, ForYouOrderSummaryState>(
        builder: ((context, state) {
      return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (list) => SingleChildScrollView(
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
                                      list.selectedItem?.title ?? "",
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: list.subCategoryItems!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index == list.selectedIndex
                                          ? GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<
                                                        ForYouOrderSummaryCubit>()
                                                    .setSelectedIndex(index);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  list.subCategoryItems![index]
                                                          .title ??
                                                      "No title",
                                                  style: context.xHeadline3
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                _expandableController.toggle();
                                                context
                                                    .read<
                                                        ForYouOrderSummaryCubit>()
                                                    .setSelectedItem(
                                                        list.subCategoryItems![
                                                            index]);
                                                context
                                                    .read<
                                                        ForYouOrderSummaryCubit>()
                                                    .setSelectedIndex(index);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  list.subCategoryItems![index]
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
                                  list.selectedItem?.text ?? '',
                                  style: context.xHeadline4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      list.selectedItem?.title ?? "-",
                                      style: context.xHeadline4,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    (list.selectedItem?.price ?? "-") + " TL",
                                    style: context.xHeadline4,
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleProvider.current.total,
                                    style: context.xHeadline3.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    (list.selectedItem?.price ?? "-") + " TL",
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
                          context: context,
                          width: 260,
                          text: LocaleProvider.current.payment,
                          onPressed: () {
                            getIt<IAppConfig>()
                                .platform
                                .adjustManager
                                ?.trackEvent(ForYouItemPaymentClickedEvent());
                            getIt<FirebaseAnalyticsManager>().logEvent(
                              UrunOdemesiTiklandiEvent(
                                list.selectedItem?.title ?? '',
                              ),
                            );

                            Atom.to(
                              PagePaths.creditCard,
                              queryParameters: {
                                'paymentType':
                                    PaymentType.package.xGetIndex.toString(),
                                'paymentObjectCode': (list.selectedItem?.id ??
                                        widget.subCategoryId)
                                    .toString(),
                                'packageName': Uri.encodeFull(
                                    list.selectedItem?.title ?? "-"),
                                'price':
                                    list.selectedItem?.price ?? 0.toString(),
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
              ),
          failure: () => const RbioBodyError());
    }));
  }
}
