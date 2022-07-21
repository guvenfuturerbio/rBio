import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';

class MagazineSelectionPage extends StatelessWidget {
  const MagazineSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
          context: context,
          title:
              RbioAppBar.textTitle(context, LocaleProvider.current.magazines)),
      body: ListView(
        scrollDirection: Atom.isWeb ? Axis.horizontal : Axis.vertical,
        children: R.constants.magazineList
            .map((e) =>
                _magazineWidget(e["imagePath"]!, e["magazineUrl"]!, e["sayi"]!))
            .toList(),
      ),
    );
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
