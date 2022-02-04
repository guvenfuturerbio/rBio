import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';

class Covid19Screen extends StatefulWidget {
  const Covid19Screen({Key? key}) : super(key: key);

  @override
  _Covid19ScreenState createState() => _Covid19ScreenState();
}

class _Covid19ScreenState extends State<Covid19Screen> {
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
    List<String> covidTitles = [
      LocaleProvider.current.covid_title_1,
      LocaleProvider.current.covid_title_2,
      LocaleProvider.current.covid_title_3,
      LocaleProvider.current.covid_title_5,
      LocaleProvider.current.covid_title_6,
      LocaleProvider.current.covid_title_7
    ];
    List cardList = [
      MopItem(R.image.covid_1, LocaleProvider.current.covid_text_1),
      MopItem(R.image.covid_2, LocaleProvider.current.covid_text_2),
      MopItem(R.image.covid_3, LocaleProvider.current.covid_text_3),
      MopItem(R.image.covid_5, LocaleProvider.current.covid_text_5),
      MopItem(R.image.covid_6, LocaleProvider.current.covid_text_6),
      MopItem(R.image.covid_7, LocaleProvider.current.covid_text_7),
    ];
    return RbioScaffold(
        appbar: RbioAppBar(
          title: getTitleBar(context),
        ),
        body: _buildBody(context, covidTitles, cardList));
  }

  Widget _buildBody(
      BuildContext context, List<String> covidTitles, List<dynamic> cardList) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 20, right: 10, left: 10, bottom: 10),
              child: InkWell(
                child: _ItemTakeCovid(
                    title: LocaleProvider.current.take_covid_19,
                    image: R.image.ic_test_icon,
                    number: LocaleProvider.current.lbl_number_hospital,
                    context: context),
                onTap: () {},
              ),
            ),
          ),

          //
          Column(
            children: [
              //
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  title == "" ? covidTitles[0] : title,
                  style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: getIt<ITheme>().mainColor),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height * 0.68,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) => {
                    setState(() {
                      _currentIndex = index;
                      title = covidTitles[index];
                    })
                  },
                ),
                items: cardList.map((card) {
                  return Builder(builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: card,
                      ),
                    );
                  });
                }).toList(),
              ),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  cardList,
                  (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
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

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {
                      controller.previousPage();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      controller.nextPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return RbioAppBar.textTitle(context, LocaleProvider.current.whats_covid);
  }
}

class MopItem extends StatelessWidget {
  String image = "";
  String text = "";
  MopItem(this.image, this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(image),
              margin: const EdgeInsets.all(30),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 30),
              child: Text(
                text,
                style: context.xHeadline3.copyWith(fontStyle: FontStyle.italic),
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
  required String title,
  required String image,
  String? number,
  EdgeInsets? margin,
  required BuildContext context,
}) =>
    Container(
      margin: margin,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(image),
            margin: const EdgeInsets.only(left: 15, right: 15),
          ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold, color: getIt<ITheme>().textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            getIt<ITheme>().textColorSecondary.withOpacity(0.7),
            getIt<ITheme>().textColorSecondary.withOpacity(0.5),
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(5, 10))
          ]),
    );
