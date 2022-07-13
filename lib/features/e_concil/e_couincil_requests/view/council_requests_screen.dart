import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../shared/view/widget/council_card.dart';
import '../model/council_request_card_models.dart';

class ECouncilRequestsScreen extends StatelessWidget {
  const ECouncilRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(title: Text(LocaleProvider.of(context).council_requests)),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          CouincilCard(
            model: CouncilCardPendingPaymentModel(
              title: LocaleProvider.of(context).pending_payment,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              date: DateTime.now(),
              price: 1500.0,
            ),
          ),
          CouincilCard(
            model: CouncilCardPendingInspectionModel(
              title: LocaleProvider.of(context).pending_inspection,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              expectedInspection: 'Omurga Röntgeni',
            ),
          ),
          CouincilCard(
            model: CouncilCardRejectedModel(
              title: LocaleProvider.of(context).rejected,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              note: 'Hastalığınız E-Konsey sistemine uymamaktadır.',
            ),
          ),
          CouincilCard(
            model: CouncilCardPendingApprovalModel(
              title: LocaleProvider.of(context).pending_approval,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
            ),
          ),
          CouincilCard(
            model: CouncilCardAppoitmentModel(
              title: LocaleProvider.of(context).council_appointment,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              date: DateTime.now(),
              councilConnectionUrl: 'ekonsey/appointment/CV45CTR5YT554.com',
            ),
          ),
        ],
      ),
    );
  }
}
