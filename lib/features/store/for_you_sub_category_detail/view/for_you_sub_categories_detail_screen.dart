import 'dart:convert';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/core.dart';
import '../../../../config/config.dart';
import '../cubit/cubit.dart';
import '../model/for_you_sub_category_detail_response.dart';

class ForYouSubCategoriesDetailScreen extends StatelessWidget {
  const ForYouSubCategoriesDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int itemId;
    final String title;

    try {
      itemId = int.parse(Atom.queryParameters['subCategoryId']!);
      title = Uri.decodeFull(Atom.queryParameters['title']!);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider(
      create: (context) =>
          ForYouSubCategoryDetailCubit(getIt())..fetchSubCategoryDetail(itemId),
      child: ForYouSubCategoriesDetailView(
        itemId: itemId,
        title: title,
      ),
    );
  }
}

class ForYouSubCategoriesDetailView extends StatefulWidget {
  final int itemId;
  final String title;

  const ForYouSubCategoriesDetailView({
    Key? key,
    required this.itemId,
    required this.title,
  }) : super(key: key);

  @override
  _ForYouSubCategoriesDetailViewState createState() =>
      _ForYouSubCategoriesDetailViewState();
}

class _ForYouSubCategoriesDetailViewState
    extends State<ForYouSubCategoriesDetailView> {
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
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        widget.title,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ForYouSubCategoryDetailCubit,
        ForYouSubCategoryDetailState>(
      builder: (context, state) {
        return state.when(
            initial: () => const SizedBox(),
            loadInProgress: () => const RbioLoading(),
            success: (list) => _buildSuccess(context, list),
            failure: () => const RbioBodyError());
      },
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    List<ForYouSubCategoryDetailResponse> list,
  ) {
    return Padding(
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
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(ForYouPackageSummaryClickedEvent());
                      getIt<FirebaseAnalyticsManager>().logEvent(
                        SizeOzelAltKategoriOzeteTiklandiEvent(
                          widget.itemId.toString(),
                        ),
                      );

                      Atom.to(
                        PagePaths.forYouOrderSummary,
                        queryParameters: {
                          'subCategoryId': (widget.itemId).toString(),
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
                  items: list.map(
                    (card) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: ListCard(
                                image: card.image!,
                                title: card.title!,
                                text: card.text!,
                              ),
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
                    list,
                    (index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? context.xPrimaryColor
                              : context.xTextInverseColor.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (list.length > 1) ...[
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
    );
  }

  Widget _buildBuyPackageButton(
    BuildContext context,
    VoidCallback onTap,
    String title,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
      child: RbioElevatedButton(
        title: title,
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
                left: 30,
                right: 30,
                top: 10,
                bottom: 8,
              ),
              child: Text(
                title,
                style: context.xHeadline3.copyWith(
                  color: context.xTextInverseColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
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
                  color: context.xTextInverseColor,
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
