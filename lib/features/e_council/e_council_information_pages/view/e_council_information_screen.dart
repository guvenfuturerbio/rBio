import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ECouncilInformationScreen extends StatelessWidget {
  const ECouncilInformationScreen({
    Key? key,
  }) : super(key: key);

  static const eCouncilInformationPageTitleKey = 'eCouncilInformationPageTitle';
  static const eCouncilInformationPageInformationKey =
      'eCouncilInformationPageInformationKey';

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
        title: Text(
          LocaleProvider.of(context).e_council,
        ),
      ),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Text(
              Atom.queryParameters[ECouncilInformationScreen
                      .eCouncilInformationPageTitleKey] ??
                  '',
              style: context.xHeadline1.copyWith(
                color: context.xPrimaryColor,
              ),
            ),

            //
            const SizedBox(height: 16),

            //
            Text(
              Atom.queryParameters[ECouncilInformationScreen
                      .eCouncilInformationPageInformationKey] ??
                  '',
              style: context.xHeadline3,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
