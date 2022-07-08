import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/e_concil/e_concil_results/model/council_card_report_model.dart';

import '../shared/view/widget/council_card.dart';

class ECouncilResultScreen extends StatelessWidget {
  const ECouncilResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      // backgroundColor: getIt<IAppConfig>().theme.eCouncilScafoldBackground,
      appbar: RbioAppBar(title: Text(LocaleProvider.of(context).council_results)),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CouincilCard(
            model: CouncilCardReportModel(
              title: LocaleProvider.of(context).council_report,
              diagnosis: 'Bel Ağrısı',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              date: DateTime.now(),
            ),
          ),
          CouincilCard(
            model: CouncilCardReportModel(
              title: LocaleProvider.of(context).council_report,
              diagnosis: 'Bel Ağrısı',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              date: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
