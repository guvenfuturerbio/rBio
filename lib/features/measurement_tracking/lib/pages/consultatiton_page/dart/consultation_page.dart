import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/widgets/utils.dart';

class ConsultationPage extends StatefulWidget {
  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        appBar: MainAppBar(
            context: context,
            title: TitleAppBarWhite(title: LocaleProvider.current.consultation),
            leading: InkWell(
                child: SvgPicture.asset(R.image.back_icon),
                onTap: () => Navigator.of(context).pop())),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            consultationChild(
                context: context,
                text: LocaleProvider.current.chat,
                image: R.image.dmchat_icon,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.CHAT_PAGE);
                }),
            consultationChild(
                context: context,
                text: LocaleProvider.current.appointment,
                image: R.image.consultation_icon,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.PATIENT_APPOINTMENT);
                }),
          ],
        ));
  }
}

Widget consultationChild(
    {BuildContext context, String text, String image, Function onPressed}) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.16,
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image,
              color: Colors.black,
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1),
          SizedBox(
            width: 8,
          ),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600))
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    ),
    onTap: () {
      onPressed();
    },
  );
}
