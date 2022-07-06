import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/e_concil/e_couincil_requests/model/council_card_models.dart';

import '../../shared/widget/council_card.dart';

class ECouncilRequestsScreen extends StatelessWidget {
  const ECouncilRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(title: Text(LocaleProvider.of(context).council_demands)),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          CouincilCard(
            model: CouncilCardPPaymentModel(
              title: LocaleProvider.of(context).pending_payment,
              diagnosis: 'Bel Agrisi',
              departmentManager: 'Prof. Dr. Ismet OZEL',
              date: DateTime.now(),
              price: 1500.0,
            ),
          ),
          CouincilCard(
            model: CouncilCardPInspectionModel(
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
              note: 'Hastalığınız E-Konsey sistemine uymamaktadır.Hastalığınız E-Konsey sistemine uymamaktadır.',
            ),
          ),
          CouincilCard(
            model: CouncilCardPApprovalModel(
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
