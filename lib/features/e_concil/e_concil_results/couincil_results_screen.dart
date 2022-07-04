import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/e_concil/e_concil_results/model/council_card_report_model.dart';

import '../shared/widget/council_card.dart';

class CouncilResultScreen extends StatelessWidget {
  const CouncilResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getIt<IAppConfig>().theme.eCouncilScafoldBackground,
      appBar: RbioAppBar(title: Text(LocaleProvider.of(context).council_results)),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
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
