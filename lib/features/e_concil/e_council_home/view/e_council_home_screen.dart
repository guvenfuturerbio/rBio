import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

import '../../SIL_DELETE_DELETE_SIL/sil.dart';
import '../../information_pages/view/e_council_information_screen.dart';

class ECouncilHomeScreen extends StatelessWidget {
  const ECouncilHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: getIt<IAppConfig>().theme.mainColor,
      fontSize: 14,
    );

    return Scaffold(
      appBar: RbioAppBar(
        title: Text(LocaleProvider.of(context).e_council),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? E-Konsey Nedir?
            InkWell(
              onTap: () {
                Atom.to(
                  PagePaths.eCouncilInformationPage,
                  queryParameters: {
                    ECouncilInformationScreen.eCouncilInformationPageTitleKey: LocaleProvider.of(context).what_is_the_e_council,
                    ECouncilInformationScreen.eCouncilInformationPageInformationKey: whatIsTheECouncil,
                  },
                );
              },
              child: Text(LocaleProvider.of(context).what_is_the_e_council, style: textStyle),
            ),
            const SizedBox(height: 16),
            //? E-Konsey Nasil Kullanilir?
            InkWell(
              onTap: () {
                Atom.to(
                  PagePaths.eCouncilInformationPage,
                  queryParameters: {
                    ECouncilInformationScreen.eCouncilInformationPageTitleKey: LocaleProvider.of(context).how_to_use_the_e_council,
                    ECouncilInformationScreen.eCouncilInformationPageInformationKey: howToUseTheECouncil,
                  },
                );
              },
              child: Text(LocaleProvider.of(context).how_to_use_the_e_council, style: textStyle),
            ),
            const SizedBox(height: 24),
            //? Konsey Taleplerim
            const _BuildCouncilCard(),
          ],
        ),
      ),
    );
  }
}

/// E-Konsey Card
class _BuildCouncilCard extends StatelessWidget {
  /// E-Konsey Card
  const _BuildCouncilCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.all(8.0),
          title: Text(LocaleProvider.of(context).e_council_requests),
          leading: const Icon(Icons.calendar_month),
          trailing: const Icon(Icons.arrow_forward_ios),
          textColor: Theme.of(context).textTheme.bodyText1!.color,
          iconColor: Theme.of(context).textTheme.bodyText1!.color,
          collapsedIconColor: Theme.of(context).textTheme.bodyText1!.color,
          collapsedTextColor: Theme.of(context).textTheme.bodyText1!.color,
          children: [
            //? Onay Bekleyen
            _BuildECouncilListTile(
              text: LocaleProvider.of(context).pending_approval,
              color: getIt<IAppConfig>().theme.eCouncilPendingApproval,
              number: 2,
            ),
            //? Ödeme Bekleyen
            _BuildECouncilListTile(
              text: LocaleProvider.of(context).pending_payment,
              color: getIt<IAppConfig>().theme.eCouncilPendingPayment,
              number: 0,
            ),
            //? Tetkik Bekleyen
            _BuildECouncilListTile(
              text: LocaleProvider.of(context).pending_inspection,
              color: getIt<IAppConfig>().theme.eCouncilPendingInspection,
              number: 0,
            ),
            //? Reddedilen
            _BuildECouncilListTile(
              text: LocaleProvider.of(context).rejected,
              color: getIt<IAppConfig>().theme.eCouncilRejected,
              number: 3,
            ),
            //? Randevu Hazır
            _BuildECouncilListTile(
              text: LocaleProvider.of(context).appointment_ready,
              color: getIt<IAppConfig>().theme.eCouncilAppointmentReady,
              number: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// E-Konsey Card List Tile
class _BuildECouncilListTile extends StatelessWidget {
  /// E-Konsey Card List Tile
  const _BuildECouncilListTile({
    Key? key,
    required this.text,
    required this.color,
    required this.number,
  }) : super(key: key);

  final String text;
  final Color color;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
      child: Row(
        children: [
          Text(text, style: Theme.of(context).textTheme.headline3!.copyWith(color: color)),
          const SizedBox(width: 16),
          Container(
            width: 18,
            height: 18,
            child: Center(
                child: Text(
              '$number',
              style: const TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
