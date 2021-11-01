import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';

class Covid19Screen extends StatefulWidget {
  const Covid19Screen({Key key}) : super(key: key);

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
      mopItem(R.image.covid_1, LocaleProvider.current.covid_text_1),
      mopItem(R.image.covid_2, LocaleProvider.current.covid_text_2),
      mopItem(R.image.covid_3, LocaleProvider.current.covid_text_3),
      mopItem(R.image.covid_5, LocaleProvider.current.covid_text_5),
      mopItem(R.image.covid_6, LocaleProvider.current.covid_text_6),
      mopItem(R.image.covid_7, LocaleProvider.current.covid_text_7),
    ];
    return Scaffold(
        appBar: MainAppBar(
          context: context,
          title: getTitleBar(context),
          leading: ButtonBackWhite(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
                  child: InkWell(
                    child: _ItemTakeCovid(
                      title: LocaleProvider.current.take_covid_19,
                      image: R.image.ic_test_icon,
                      number: LocaleProvider.current.lbl_number_hospital,
                    ),
                    onTap: () {
                      AnalyticsManager()
                          .sendEvent(new Covid19PcrTestClickEvent());
                    },
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        title == "" ? covidTitles[0] : title,
                        style: TextStyle(
                            color: R.color.blue, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: card,
                            ),
                          );
                        });
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(cardList, (index, url) {
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
        ));
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.current.whats_covid);
  }
}

class mopItem extends StatelessWidget {
  String image = "";
  String text = "";
  mopItem(this.image, this.text);
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(image),
              margin: EdgeInsets.all(30),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(image),
            margin: EdgeInsets.only(left: 15, right: 15),
          ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
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
            R.color.gray,
            R.color.grey,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
