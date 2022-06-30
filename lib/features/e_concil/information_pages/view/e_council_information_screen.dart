import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ECouncilInformationScreen extends StatelessWidget {
  const ECouncilInformationScreen({
    Key? key,
  }) : super(key: key);

  static const eCouncilInformationPageTitleKey = 'eCouncilInformationPageTitle';
  static const eCouncilInformationPageInformationKey = 'eCouncilInformationPageInformationKey';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(title: Text(LocaleProvider.of(context).e_council)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Atom.queryParameters[eCouncilInformationPageTitleKey] ?? '', style: TextStyle(color: getIt<IAppConfig>().theme.mainColor, fontSize: 16)),
              const SizedBox(height: 16),
              Text(
                Atom.queryParameters[eCouncilInformationPageInformationKey] ?? '',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
