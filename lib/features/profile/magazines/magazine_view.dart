import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';

class MagazineSelectionPage extends StatefulWidget {
  const MagazineSelectionPage({Key? key}) : super(key: key);

  @override
  _MagazineSelectionPageState createState() => _MagazineSelectionPageState();
}

class _MagazineSelectionPageState extends State<MagazineSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RbioAppBar(
            title: RbioAppBar.textTitle(
                context, LocaleProvider.current.magazines)),
        body: ListView(
          scrollDirection: Atom.isWeb ? Axis.horizontal : Axis.vertical,
          children: <Widget>[
            _magazineWidget(R.image.guvenin_1,
                "https://www.guvenin.com.tr/sayi1", "Sayı 1"),
            _magazineWidget(R.image.guvenin_2,
                "https://www.guvenin.com.tr/sayi2", "Sayı 2"),
            _magazineWidget(R.image.guvenin_3,
                "https://www.guvenin.com.tr/sayi3", "Sayı 3"),
            _magazineWidget(R.image.guvenin_4,
                "https://www.guvenin.com.tr/sayi4", "Sayı 4"),
          ],
        ));
  }

  Padding _magazineWidget(String imagePath, String magazineUrl, String sayi) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
          onTap: () {
            Atom.isWeb
                ? launchUrl(Uri.parse(magazineUrl))
                : Atom.to(PagePaths.magazines,
                    queryParameters: {"magazineUrl": magazineUrl});
          },
          child: Center(
            child: Column(
              children: [
                Text(
                  sayi,
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                    height: Atom.height / 2.2,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fitHeight,
                    )),
              ],
            ),
          )),
    );
  }
}
