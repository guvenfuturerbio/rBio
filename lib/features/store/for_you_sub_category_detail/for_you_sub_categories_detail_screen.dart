import 'dart:convert';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_sub_categories_detail_vm.dart';

class ForYouSubCategoriesDetailScreen extends StatefulWidget {
  var itemId;
  String title;

  ForYouSubCategoriesDetailScreen({
    Key key,
    this.itemId,
    this.title,
  }) : super(key: key);

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
      widget.itemId = int.parse(Atom.queryParameters['subCategoryId']);
      widget.title = Uri.decodeFull(Atom.queryParameters['title']);
    } catch (_) {
      return RbioRouteError();
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
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                widget.title,
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
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return RbioLoadingOverlay(
          isLoading: vm.showLoadingOverlay,
          progressIndicator: RbioLoading(),
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
                            AnalyticsManager().sendEvent(
                              SubCategorySummaryClicked(
                                subCategoryName: title,
                              ),
                            );
                            Atom.to(
                              PagePaths.ORDER_SUMMARY,
                              queryParameters: {
                                'subCategoryId': widget.itemId.toString(),
                                'categoryName': widget.title,
                              },
                            );
                          },
                          LocaleProvider.current.buy_package,
                        ),
                      ),
                    ],
                  ),

                  //
                  Container(
                    child: Column(
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
                          items: vm.cardList.map(
                            (card) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      child: card,
                                    ),
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(
                            vm.cardList,
                            (index, url) {
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? getIt<ITheme>().mainColor
                                      : getIt<ITheme>()
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
                            IconButton(
                                icon: Icon(Icons.arrow_left),
                                onPressed: () {
                                  controller.previousPage();
                                }),
                            IconButton(
                              icon: Icon(Icons.arrow_right),
                              onPressed: () {
                                controller.nextPage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildBuyPackageButton(
    BuildContext context,
    VoidCallback onTap,
    String title,
  ) {
    return FadeInUp(
      duration: Duration(milliseconds: 1000),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
        child: InkWell(
          child: _ItemTakeCovid(
            context: context,
            title: title,
            image: R.image.ic_test_icon,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class mopItem extends StatelessWidget {
  String image = "";
  String text = "";
  String title = "";

  mopItem(
    this.image,
    this.title,
    this.text,
  );

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //
            Container(
              constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
              child: image != null
                  ? Image.memory(base64Decode(image))
                  : Image.asset(R.image.covid_cat_icon),
              margin: EdgeInsets.all(30),
            ),

            //
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 8),
              child: Text(
                title,
                style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 8,
                bottom: 30,
              ),
              child: Text(
                text,
                style: context.xHeadline3.copyWith(
                  color: getIt<ITheme>().textColorSecondary,
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

Widget _ItemTakeCovid({
  String title,
  String image,
  String number,
  bool isFocused = false,
  EdgeInsets margin,
  BuildContext context,
}) =>
    Container(
      margin: margin,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          colors: [
            getIt<ITheme>().mainColor,
            getIt<ITheme>().mainColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: getIt<ITheme>().textColorSecondary.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(5, 10),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: title == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>().textColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Positioned(
            child: Container(
              child: Transform.rotate(
                angle: -math.pi / 1.0,
                child: SvgPicture.asset(R.image.ic_back_white),
              ),
              margin: EdgeInsets.only(left: 15, right: 5),
            ),
            right: 0,
          ),
        ],
      ),
    );
