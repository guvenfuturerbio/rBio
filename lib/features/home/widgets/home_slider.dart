import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
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
    return Consumer<HomeVm>(builder: (
      BuildContext context,
      HomeVm vm,
      Widget child,
    ) {
      return SizedBox(
        height: getHeight(context),
        width: Atom.width,
        child: Stack(
          children: [
            //
            Positioned.fill(
              child: CarouselSlider(
                items: cardList,
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: !vm.isForDelete,
                  enlargeCenterPage: true,
                  //aspectRatio: 1.0,
                  viewportFraction: 1,
                  // scrollPhysics: vm.isForDelete
                  //     ? NeverScrollableScrollPhysics()
                  //     : ClampingScrollPhysics(),
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
                  children: cardList.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : getIt<ITheme>().mainColor)
                                    .withOpacity(
                              _current == entry.key ? 0.9 : 0.4,
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
    });
  }

  double getHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width < 576) {
      // Mobile
      return height * 0.25;
    } else if (width >= 576 && width < 850) {
      // Tablet
      return height * 0.25;
    } else {
      // Desktop
      return height * 0.25;
    }
  }

  List<Widget> cardList = [
    SizedBox(
      width: Atom.width,
      child: Card(
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: R.sizes.borderRadiusCircular),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            "https://images.unsplash.com/photo-1636512957897-f3c28ba56e9f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2340&q=80",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ),
    SizedBox(
      width: Atom.width,
      child: Card(
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: R.sizes.borderRadiusCircular),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            "https://images.unsplash.com/photo-1636512957897-f3c28ba56e9f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2340&q=80",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ),
    SizedBox(
      width: Atom.width,
      child: Card(
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: R.sizes.borderRadiusCircular),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            "https://images.unsplash.com/photo-1636512957897-f3c28ba56e9f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2340&q=80",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ),
  ];
}
