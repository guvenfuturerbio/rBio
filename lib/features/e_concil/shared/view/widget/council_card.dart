import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/core.dart';
import '../../../e_concil_results/model/council_card_report_model.dart';
import '../../../e_couincil_requests/model/council_request_card_models.dart';
import '../../model/council_card_payment_model.dart';
import '../../model/icouncil_card_model.dart';

class CouincilCard extends StatelessWidget {
  const CouincilCard({
    Key? key,
    required this.model,
    this.padding,
  }) : super(key: key);
  final ICouncilCardModel model;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //? Title
          if (model is! CouncilCardPaymentModel) _BuildCouncilCardTitle(model: model),
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
        borderRadius: BorderRadius.only(
          topLeft: R.sizes.radiusCircular,
          topRight: R.sizes.radiusCircular,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 2, top: 2, bottom: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                model.title,
                style: context.xHeadline3.copyWith(
                  color: model is CouncilCardReportModel ? Colors.black : Colors.white,
                ),
              ),
            ),

            //? Ode
            if (model is CouncilCardPendingPaymentModel)
              _BuildCouncilCardTitleButton(
                text: LocaleProvider.of(context).pay2,
                textColor: model.color,
                onPressed: () {
                  Atom.to(PagePaths.eCouncilPaymentPreviewPage);
                },
              ),

            //? Yukle
            if (model is CouncilCardPendingInspectionModel)
              _BuildCouncilCardTitleButton(
                text: LocaleProvider.of(context).upload,
                textColor: model.color,
                onPressed: () {
                  Atom.to(PagePaths.eCouncilInspectionUploadPage);
                },
              ),

            //? Katil
            if (model is CouncilCardAppoitmentModel)
              _BuildCouncilCardTitleButton(
                text: LocaleProvider.of(context).join,
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
          RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.only(topRight: R.sizes.radiusCircular),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: model is CouncilCardPaymentModel ? R.sizes.radiusCircular : const Radius.circular(0.0),
          topRight: model is CouncilCardPaymentModel ? R.sizes.radiusCircular : const Radius.circular(0.0),
          bottomLeft: R.sizes.radiusCircular,
          bottomRight: R.sizes.radiusCircular,
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? Teşhis
          _BuildCouncilCardTile(
            title: LocaleProvider.of(context).diagnosis,
            data: model.diagnosis,
          ),

          //? Bölüm Sorumlusu
          _BuildCouncilCardTile(
            title: LocaleProvider.of(context).department_manager,
            data: model.departmentManager,
          ),

          //? Tarih
          if (model is CouncilCardReportModel ||
              model is CouncilCardPendingPaymentModel ||
              model is CouncilCardPendingApprovalModel ||
              model is CouncilCardAppoitmentModel ||
              model is CouncilCardPaymentModel)
            _BuildCouncilCardDate(model: model),

          //? Tetkik
          if (model is CouncilCardPendingInspectionModel) _BuildCouncilCardInspection(model: model),
          //? Reddedilen
          if (model is CouncilCardRejectedModel) _BuildCouncilCardNote(model: model),
          //? Konsey baglanti linki
          if (model is CouncilCardPendingApprovalModel || model is CouncilCardAppoitmentModel) _BuildCouncilCardConnectionLink(model: model),
          //? Katilacak Doktor Sayisi
          if (model is CouncilCardPaymentModel) _BuildCouncilCardNumberOfDoctorsToAttend(model: model),
          //? Fiyat
          if (model is CouncilCardPendingPaymentModel || model is CouncilCardPaymentModel) _BuildCouncilCardPrice(model: model),
        ],
      ),
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
  Widget build(BuildContext context) =>
      _BuildCouncilCardTile(title: LocaleProvider.of(context).expected_inspection, data: (model as CouncilCardPendingInspectionModel).expectedInspection);
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
            _BuildCouncilCardTile(
              title: model is CouncilCardReportModel ? LocaleProvider.of(context).date : LocaleProvider.of(context).date_and_hour,
              //? Konsey Raporu
              data: model is CouncilCardReportModel
                  ? (model as CouncilCardReportModel).dateToString(
                      (model as CouncilCardReportModel).date,
                    )
                  //? Odeme bekleniyor
                  : model is CouncilCardPendingPaymentModel
                      ? (model as CouncilCardPendingPaymentModel).dateToString(
                          (model as CouncilCardPendingPaymentModel).date,
                        )
                      //? Onay bekleniyor
                      : model is CouncilCardPendingApprovalModel
                          ? (model as CouncilCardPendingApprovalModel).date
                          //? Randevu
                          : model is CouncilCardAppoitmentModel
                              ? (model as CouncilCardAppoitmentModel).dateToString((model as CouncilCardAppoitmentModel).date)
                              //? Odeme
                              : model is CouncilCardPaymentModel
                                  ? (model as CouncilCardPaymentModel).dateToString(
                                      (model as CouncilCardPaymentModel).date,
                                    )
                                  : null,
            ),
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
        _BuildCouncilCardTile(
          title: LocaleProvider.of(context).price,
          data: model is CouncilCardPendingPaymentModel
              ? '${(model as CouncilCardPendingPaymentModel).price.toStringAsFixed(2)} TL'
              : model is CouncilCardPaymentModel
                  ? '${(model as CouncilCardPaymentModel).price.toStringAsFixed(2)} TL'
                  : '',
        ),
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
        _BuildCouncilCardTile(
          title: LocaleProvider.of(context).note,
          data: (model as CouncilCardRejectedModel).note,
        ),
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
        Text(
          LocaleProvider.of(context).council_connection_link,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (model is CouncilCardPendingApprovalModel)
              Flexible(
                  child: FittedBox(
                      child: Text((model as CouncilCardPendingApprovalModel).councilConnectionUrl, style: context.xSubtitle2.copyWith(color: Colors.grey)))),
            if (model is CouncilCardAppoitmentModel)
              Flexible(
                  child: FittedBox(
                      child: Text((model as CouncilCardAppoitmentModel).councilConnectionUrl, style: context.xSubtitle2.copyWith(color: Colors.blue)))),
            SizedBox(
              height: 20,
              child: IconButton(
                icon: const Icon(Icons.copy, color: Colors.grey),
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  if (model is CouncilCardPendingApprovalModel) {
                    await Clipboard.setData(ClipboardData(text: (model as CouncilCardPendingApprovalModel).councilConnectionUrl));
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
            ),
          ],
        ),
      ],
    );
  }
}

//! BodyNumberOfDoctorsToAttend - BodyNumberOfDoctorsToAttend - BodyNumberOfDoctorsToAttend - BodyNumberOfDoctorsToAttend - BodyNumberOfDoctorsToAttend

class _BuildCouncilCardNumberOfDoctorsToAttend extends StatelessWidget {
  const _BuildCouncilCardNumberOfDoctorsToAttend({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ICouncilCardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BuildCouncilCardTile(
          title: LocaleProvider.of(context).number_of_doctors_to_attend,
          data: (model as CouncilCardPaymentModel).numberOfDoctorsToAttend.toString(),
        ),
      ],
    );
  }
}

//! BodyCouncilCardTile - BodyCouncilCardTile - BodyCouncilCardTile - BodyCouncilCardTile - BodyCouncilCardTile

class _BuildCouncilCardTile extends StatelessWidget {
  const _BuildCouncilCardTile({
    Key? key,
    required this.title,
    this.data,
  }) : super(key: key);

  final String title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
        ),
        Text(
          data ?? '',
          textAlign: TextAlign.justify,
          style: context.xSubtitle2,
        ),
        R.widgets.hSizer4,
      ],
    );
  }
}
