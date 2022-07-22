import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../shared/model/council_card_payment_model.dart';
import '../../shared/view/widget/council_card.dart';

class ECouncilPaymentPreviewScreen extends StatelessWidget {
  const ECouncilPaymentPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
      ),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleProvider.of(context)
                .your_council_request_has_been_accepted_by_our_doctors_below_are_the_details,
            textAlign: TextAlign.center,
            style: context.xHeadline4,
          ),
          R.widgets.hSizer12,
          CouincilCard(
            padding: EdgeInsets.zero,
            model: CouncilCardPaymentModel(
              diagnosis: 'Bel Ağrısı',
              departmentManager: 'Prof. Dr. İsmet Özel',
              title: '',
              date: DateTime.now(),
              numberOfDoctorsToAttend: 4,
              price: 1500,
            ),
          ),

          //
          const Spacer(),

          //
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.of(context).btn_cancel,
                  backColor: Colors.red,
                  fontWeight: FontWeight.bold,
                  onTap: () {},
                ),
              ),

              //
              R.widgets.wSizer12,

              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.of(context).btn_confirm,
                  fontWeight: FontWeight.bold,
                  onTap: () {
                    Atom.to(PagePaths.eCouncilPaymentPage);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
