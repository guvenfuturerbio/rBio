// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onedosehealth/features/e_concil/e_concil_results/model/council_card_report_model.dart';

import '../../../../core/core.dart';
import '../../e_couincil_requests/model/council_card_models.dart';
import 'icouncil_card_model.dart';

class CouincilCard extends StatelessWidget {
  const CouincilCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //? Title
          _BuildCouncilCardTitle(model: model),
          //? Body
          _BuildCouncilCardBody(model: model),
        ],
      ),
    );
  }
}

//! TITLE - TITLE - TITLE - TITLE - TITLE - TITLE
class _BuildCouncilCardTitle extends StatelessWidget {
  const _BuildCouncilCardTitle({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(model.color),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.title, style: context.xHeadline3.copyWith(color: model is CouncilCardReportModel ? Colors.black : Colors.white)),
            //? Ode
            if (model is CouncilCardPPaymentModel)
              _BuildCouncilCardTitleButton(
                text: LocaleProvider.of(context).pay2,
                textColor: model.color,
                onPressed: () {},
              ),
            //? Yukle
            if (model is CouncilCardPInspectionModel)
              _BuildCouncilCardTitleButton(
                text: LocaleProvider.of(context).upload,
                textColor: model.color,
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }
}

//! TitleButton - TitleButton - TitleButton - TitleButton - TitleButton - TitleButton

/// Konsey kart'larinin baslik kisminda yer alan button
class _BuildCouncilCardTitleButton extends StatelessWidget {
  /// Konsey kart'larinin baslik kisminda yer alan button
  const _BuildCouncilCardTitleButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text, style: context.xHeadline3.copyWith(color: Color(textColor))),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Color(textColor).withOpacity(.3)),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

//! BODY - BODY - BODY - BODY - BODY - BODY

class _BuildCouncilCardBody extends StatelessWidget {
  const _BuildCouncilCardBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? Teşhis
          Text(
            LocaleProvider.of(context).diagnosis,
            style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
          ),
          Text(model.diagnosis, style: context.xSubtitle2),
          R.sizes.hSizer4,
          //? Bölüm Sorumlusu
          Text(
            LocaleProvider.of(context).department_manager,
            style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
          ),
          Text(model.departmentManager, style: context.xSubtitle2),

          //? Tarih
          if (model is CouncilCardReportModel || model is CouncilCardPPaymentModel || model is CouncilCardPApprovalModel || model is CouncilCardAppoitmentModel)
            _BuildCouncilCardDate(model: model),
          //? Fiyat
          if (model is CouncilCardPPaymentModel) _BuildCouncilCardPrice(model: model),
          //? Tetkik
          if (model is CouncilCardPInspectionModel) _BuildCouncilCardInspection(model: model),
          //? Reddedilen
          if (model is CouncilCardRejectedModel) _BuildCouncilCardNote(model: model),
          //? Konsey baglanti linki
          if (model is CouncilCardPApprovalModel || model is CouncilCardAppoitmentModel) _BuildCouncilCardConnectionLink(model: model),
        ],
      ),
    );
  }
}

//! BodyDate - BodyDate - BodyDate - BodyDate - BodyDate - BodyDate
class _BuildCouncilCardDate extends StatelessWidget {
  const _BuildCouncilCardDate({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            R.sizes.hSizer4,
            Text(
              model is CouncilCardReportModel ? LocaleProvider.of(context).date : LocaleProvider.of(context).date_and_hour,
              style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
            ),
            if (model is CouncilCardReportModel)
              Text((model as CouncilCardReportModel).dateToString((model as CouncilCardReportModel).date), style: context.xSubtitle2),
            if (model is CouncilCardPPaymentModel)
              Text((model as CouncilCardPPaymentModel).dateToString((model as CouncilCardPPaymentModel).date), style: context.xSubtitle2),
            if (model is CouncilCardPApprovalModel) Text((model as CouncilCardPApprovalModel).date, style: context.xSubtitle2),
            if (model is CouncilCardAppoitmentModel)
              Text((model as CouncilCardAppoitmentModel).dateToString((model as CouncilCardAppoitmentModel).date), style: context.xSubtitle2),
          ],
        ),

        const Spacer(),
        //? Görüntüle
        if (model is CouncilCardReportModel)
          RbioElevatedButton(
            title: LocaleProvider.of(context).show,
            padding: EdgeInsets.zero,
            onTap: () {
              Atom.to(PagePaths.eCouncilResultDetailPage);
            },
          ),
      ],
    );
  }
}

//! BodyPrice - BodyPrice - BodyPrice - BodyPrice - BodyPrice - BodyPrice

class _BuildCouncilCardPrice extends StatelessWidget {
  const _BuildCouncilCardPrice({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        R.sizes.hSizer4,
        Text(
          LocaleProvider.of(context).price,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Text('${(model as CouncilCardPPaymentModel).price.toStringAsFixed(0)} TL', style: context.xSubtitle2),
      ],
    );
  }
}

//! BodyInspection - BodyInspection - BodyInspection - BodyInspection - BodyInspection - BodyInspection

class _BuildCouncilCardInspection extends StatelessWidget {
  const _BuildCouncilCardInspection({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        R.sizes.hSizer4,
        Text(
          LocaleProvider.of(context).expected_inspection,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Text((model as CouncilCardPInspectionModel).expectedInspection, style: context.xSubtitle2),
      ],
    );
  }
}

//! BodyNote - BodyNote - BodyNote - BodyNote - BodyNote - BodyNote

class _BuildCouncilCardNote extends StatelessWidget {
  const _BuildCouncilCardNote({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        R.sizes.hSizer4,
        Text(
          LocaleProvider.of(context).note,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Text((model as CouncilCardRejectedModel).note, style: context.xSubtitle2, textAlign: TextAlign.justify),
      ],
    );
  }
}

//! BodyConnectionLink - BodyConnectionLink - BodyConnectionLink - BodyConnectionLink - BodyConnectionLink - BodyConnectionLink

class _BuildCouncilCardConnectionLink extends StatelessWidget {
  const _BuildCouncilCardConnectionLink({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        R.sizes.hSizer4,
        Text(
          LocaleProvider.of(context).council_connection_link,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (model is CouncilCardPApprovalModel)
              Flexible(child: Text((model as CouncilCardPApprovalModel).councilConnectionUrl, style: context.xSubtitle2.copyWith(color: Colors.grey))),
            if (model is CouncilCardAppoitmentModel)
              Flexible(child: Text((model as CouncilCardAppoitmentModel).councilConnectionUrl, style: context.xSubtitle2.copyWith(color: Colors.blue))),
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.grey),
              onPressed: () async {
                if (model is CouncilCardPApprovalModel) {
                  await Clipboard.setData(ClipboardData(text: (model as CouncilCardPApprovalModel).councilConnectionUrl));
                } else if (model is CouncilCardAppoitmentModel) {
                  await Clipboard.setData(ClipboardData(text: (model as CouncilCardAppoitmentModel).councilConnectionUrl));
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(LocaleProvider.of(context).copied),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
