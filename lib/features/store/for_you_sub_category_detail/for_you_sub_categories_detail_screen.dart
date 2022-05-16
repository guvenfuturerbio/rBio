import 'dart:convert';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_sub_categories_detail_vm.dart';

class ForYouSubCategoriesDetailScreen extends StatefulWidget {
  var itemId;
  String? title;

  ForYouSubCategoriesDetailScreen({Key? key}) : super(key: key);

  @override
  _ForYouSubCategoriesDetailScreenState createState() =>
      _ForYouSubCategoriesDetailScreenState();
}

class _ForYouSubCategoriesDetailScreenState
    extends State<ForYouSubCategoriesDetailScreen> {
  CarouselController controller = CarouselController();

  int _currentIndex = 0;
  String text = "";
  String title = "";

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.itemId =
          int.parse(Atom.queryParameters['subCategoryId'] as String);
      widget.title = Uri.decodeFull(Atom.queryParameters['title'] as String);
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<ForYouSubCategoriesDetailScreenVm>(
      create: (context) => ForYouSubCategoriesDetailScreenVm(
        context,
        widget.itemId,
      ),
      child: Consumer<ForYouSubCategoriesDetailScreenVm>(
        builder: (
          BuildContext context,
          ForYouSubCategoriesDetailScreenVm vm,
          Widget? child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                widget.title!,
              ),
            ),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForYouSubCategoriesDetailScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return RbioLoadingOverlay(
          isLoading: vm.showLoadingOverlay,
          progressIndicator: const RbioLoading(),
          opacity: 0.26,
          color: Colors.black,
          child: Padding(
            padding: kIsWeb
                ? EdgeInsets.only(
                    top: 50,
                    left: Atom.size.width < 800
                        ? Atom.size.width * 0.03
                        : Atom.size.width * 0.10,
                    right: Atom.size.width < 800
                        ? Atom.size.width * 0.03
                        : Atom.size.width * 0.10,
                  )
                : EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //
                  Row(
                    children: [
                      //
                      Expanded(
                        child: _buildBuyPackageButton(
                          context,
                          () {
                            getIt<AdjustManager>()
                                .trackEvent(ForYouPackageSummaryClickedEvent());
                            getIt<FirebaseAnalyticsManager>().logEvent(
                              SizeOzelAltKategoriOzeteTiklandiEvent(
                                widget.itemId.toString(),
                              ),
                            );
                            Atom.to(
                              PagePaths.orderSummary,
                              queryParameters: {
                                'subCategoryId':
                                    (widget.itemId ?? '').toString(),
                                'categoryName': widget.title ?? '',
                              },
                            );
                          },
                          LocaleProvider.current.buy_package,
                        ),
                      ),
                    ],
                  ),

                  //
                  Column(
                    children: [
                      CarouselSlider(
                        carouselController: controller,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          height: MediaQuery.of(context).size.height * 0.68,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) => {
                            setState(() {
                              _currentIndex = index;
                            })
                          },
                        ),
                        items: vm.cardList?.map(
                          (card) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    elevation: R.sizes.defaultElevation,
                                    child: card,
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(
                          vm.cardList ?? [],
                          (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? getIt<IAppConfig>().theme.mainColor
                                    : getIt<IAppConfig>()
                                        .theme
                                        .textColorSecondary
                                        .withOpacity(0.5),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if ((vm.cardList ?? []).length > 1) ...[
                            IconButton(
                                icon: const Icon(Icons.arrow_left),
                                onPressed: () {
                                  controller.previousPage();
                                }),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: () {
                                controller.nextPage();
                              },
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildBuyPackageButton(
    BuildContext context,
    VoidCallback onTap,
    String title,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
      child: InkWell(
        child: _itemTakeCovid(
          context: context,
          title: title,
          image: R.image.test,
        ),
        onTap: onTap,
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  String? image;
  String text = "";
  String title = "";

  ListCard({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //
            Container(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
              child: image != null
                  ? Image.memory(base64Decode(image!))
                  : Image.asset(R.image.covidCat),
              margin: const EdgeInsets.all(30),
            ),

            //
            Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 8),
              child: Text(
                title,
                style: context.xHeadline3.copyWith(
                    color: getIt<IAppConfig>().theme.textColorSecondary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 8,
                bottom: 30,
              ),
              child: Text(
                text,
                style: context.xHeadline3.copyWith(
                  color: getIt<IAppConfig>().theme.textColorSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _itemTakeCovid({
  String? title,
  String? image,
  EdgeInsets? margin,
  required BuildContext context,
}) =>
    Container(
      margin: margin,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: R.sizes.borderRadiusCircular,
        gradient: LinearGradient(
          colors: [
            getIt<IAppConfig>().theme.mainColor,
            getIt<IAppConfig>().theme.mainColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: getIt<IAppConfig>().theme.textColorSecondary.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(5, 10),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: title == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.xHeadline3.copyWith(
                          color: getIt<IAppConfig>().theme.textColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),

          //
          Positioned(
            child: Container(
              child: Transform.rotate(
                angle: -math.pi / 1.0,
                child: SvgPicture.asset(R.image.backWhite),
              ),
              margin: const EdgeInsets.only(left: 15, right: 5),
            ),
            right: 0,
          ),
        ],
      ),
    );
