import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../shared/model/council_card_payment_model.dart';
import '../../shared/view/widget/council_card.dart';

class ECouncilPaymentScreen extends StatefulWidget {
  const ECouncilPaymentScreen({Key? key}) : super(key: key);

  @override
  State<ECouncilPaymentScreen> createState() => _ECouncilPaymentScreenState();
}

class _ECouncilPaymentScreenState extends State<ECouncilPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(),
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
    final String text =
        LocaleProvider.of(context).after_payment_you_can_reach_the_details_of_your_council_appointment_and_the_council_connection_link_in_your_council_requests;

    List<String> splitList = text.split(LocaleProvider.of(context).council_requests);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight - 32),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //? Konsey Karti
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
                  R.widgets.hSizer12,
                  const Spacer(),
                  //? Konsey Taleprim bilgilendirme yazisi
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: context.xHeadline4,
                      children: <TextSpan>[
                        TextSpan(text: splitList[0]),
                        TextSpan(
                          text: LocaleProvider.of(context).council_requests,
                          style: context.xHeadline4.copyWith(
                            color: getIt<IAppConfig>().theme.mainColor,
                          ),
                        ),
                        TextSpan(text: splitList[1]),
                      ],
                    ),
                  ),
                  R.widgets.hSizer12,
                  //? Fiyat alani
                  const _BuildPriceField(),
                  R.widgets.hSizer12,
                  //? Button alani
                  const _BuildButtonsField(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildPriceField extends StatelessWidget {
  const _BuildPriceField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleProvider.of(context).price,
            style: context.xHeadline4.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '1500.00 TL',
            style: context.xHeadline4.copyWith(
              color: getIt<IAppConfig>().theme.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildButtonsField extends StatefulWidget {
  const _BuildButtonsField({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildButtonsField> createState() => _BuildButtonsFieldState();
}

class _BuildButtonsFieldState extends State<_BuildButtonsField> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //? Indirim alani
        Visibility(
          visible: isOpened,
          child: RbioTextFormField(
            hintText: LocaleProvider.of(context).discount_code,
            suffixIcon: kIsWeb
                ? null
                : GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(R.image.qr, width: 24),
                    ),
                    onTap: () {},
                  ),
          ),
        ),
        R.widgets.hSizer12,
        //? Inidirim ve onayla butonlari
        Row(
          children: [
            Expanded(
              child: RbioElevatedButton(
                title: isOpened ? LocaleProvider.of(context).apply_discount : LocaleProvider.of(context).add_discount_code,
                fontWeight: FontWeight.bold,
                textColor: isOpened ? Colors.white : Colors.black,
                backColor: isOpened ? getIt<IAppConfig>().theme.mainColor : Colors.white,
                onTap: () {
                  setState(() {
                    isOpened = true;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RbioElevatedButton(
                title: LocaleProvider.of(context).btn_confirm,
                fontWeight: FontWeight.bold,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
