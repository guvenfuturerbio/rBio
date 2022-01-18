import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';
import '../viewmodel/home_vm.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(
      builder: (
        BuildContext context,
        HomeVm vm,
        Widget child,
      ) {
        return Container(
          height: getHeight(context),
          width: Atom.width,
          margin: EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: vm.bannerTabsModel.isEmpty
              ? SizedBox()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    //
                    Positioned.fill(
                      child: CarouselSlider.builder(
                        itemCount: vm.bannerTabsModel.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: getIt<ITheme>().cardBackgroundColor,
                              borderRadius: R.sizes.borderRadiusCircular,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (vm.isForDelete) {
                                  vm.addWidget(vm.key5);
                                } else {
                                  if (vm
                                      .bannerTabsModel[itemIndex].destinationUrl
                                      .contains('http')) {
                                    launch(vm.bannerTabsModel[itemIndex]
                                        .destinationUrl);
                                  } else {
                                    Atom.to(vm.bannerTabsModel[itemIndex]
                                        .destinationUrl);
                                  }
                                }
                              },
                              child: ClipRRect(
                                borderRadius: R.sizes.borderRadiusCircular,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      vm.bannerTabsModel[itemIndex].imageUrl,
                                  errorWidget: (context, url, error) =>
                                      Center(child: Icon(Icons.error)),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: HomeSizer.instance.getBodySliderHeight(),
                          autoPlay: !vm.isForDelete,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),
                    ),

                    //
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: !vm.isForDelete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: vm.bannerTabsModel.asMap().entries.map(
                            (entry) {
                              return GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(entry.key);
                                },
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getIt<ITheme>()
                                        .mainColor
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4),
                                    border: Border.all(
                                      color: R.color.white,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  double getHeight(BuildContext context) {
    return HomeSizer.instance.getBodySliderHeight();
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
