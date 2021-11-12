import 'dart:convert';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_sub_categories_detail_vm.dart';

class ForYouSubCategoriesDetailScreen extends StatefulWidget {
  var itemId;
  String title;

  ForYouSubCategoriesDetailScreen({this.itemId, this.title});

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
      return RbioError();
    }

    return ChangeNotifierProvider<ForYouSubCategoriesDetailScreenVm>(
      create: (context) =>
          ForYouSubCategoriesDetailScreenVm(context, widget.itemId),
      child: Consumer<ForYouSubCategoriesDetailScreenVm>(
        builder: (BuildContext context, ForYouSubCategoriesDetailScreenVm value,
            Widget child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: getTitleBar(context),
              leading: ButtonBackWhite(context),
            ),
            body: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : LoadingOverlay(
                    isLoading: value.showLoadingOverlay,
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
                                  : Atom.size.width * 0.10)
                          : EdgeInsets.zero,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
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
                                          'subCategoryId':
                                              widget.itemId.toString(),
                                          'categoryName': widget.title,
                                        },
                                      );
                                    },
                                    LocaleProvider.current.buy_package,
                                  ),
                                ),

                                //
                                // Expanded(
                                //   child: _buildBuyPackageButton(
                                //     context,
                                //     () async {
                                //       await value.addToCart(
                                //           context, widget.itemId.toString());
                                //     },
                                //     LocaleProvider.current.add_cart,
                                //   ),
                                // ),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: controller,
                                    options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.68,
                                      aspectRatio: 2.0,
                                      onPageChanged: (index, reason) => {
                                        setState(() {
                                          _currentIndex = index;
                                        })
                                      },
                                    ),
                                    items: value.cardList.map((card) {
                                      return Builder(
                                          builder: (BuildContext context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            child: card,
                                          ),
                                        );
                                      });
                                    }).toList(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: map<Widget>(value.cardList,
                                        (index, url) {
                                      return Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentIndex == index
                                              ? R.color.blue
                                              : Colors.grey,
                                        ),
                                      );
                                    }),
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
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  FadeInUp _buildBuyPackageButton(
      BuildContext context, VoidCallback onTap, String title) {
    return FadeInUp(
      duration: Duration(milliseconds: 1000),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
        child: InkWell(
          child: _ItemTakeCovid(
              title: title, //LocaleProvider.of(context).take_covid_19,
              image: R.image
                  .ic_test_icon //LocaleProvider.of(context).lbl_number_hospital,
              ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: widget.title);
  }
}

class mopItem extends StatelessWidget {
  String image = "";
  String text = "";
  String title = "";
  mopItem(this.image, this.title, this.text);
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
              child: image != null
                  ? Image.memory(base64Decode(image))
                  : Image.asset(R.image.covid_cat_icon),
              margin: EdgeInsets.all(30),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 8),
              child: Text(
                title,
                style: TextStyle(
                    color: R.color.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 30),
              child: Text(
                text,
                style: TextStyle(
                    color: R.color.black, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _ItemTakeCovid(
        {String title,
        String image,
        String number,
        bool isFocused = false,
        EdgeInsets margin}) =>
    Container(
      margin: margin,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
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
          )
          /*Container(
            child: Text(number,
                style:
                    TextStyle(color: Colors.white.withAlpha(50), fontSize: 14)),
          )*/
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            R.color.blue,
            R.color.blue,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
