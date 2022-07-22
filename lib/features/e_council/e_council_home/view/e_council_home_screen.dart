import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../SIL_DELETE_DELETE_SIL/sil.dart';
import '../../e_council_information_pages/view/e_council_information_screen.dart';

class ECouncilHomeScreen extends StatelessWidget {
  const ECouncilHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
        title: Text(LocaleProvider.of(context).e_council),
      ),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = context.xHeadline1.copyWith(
      color: context.xPrimaryColor,
      decoration: TextDecoration.underline,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //? E-Konsey Nedir?
                  InkWell(
                    onTap: () {
                      Atom.to(
                        PagePaths.eCouncilInformationPage,
                        queryParameters: {
                          ECouncilInformationScreen
                                  .eCouncilInformationPageTitleKey:
                              LocaleProvider.of(context).what_is_the_e_council,
                          ECouncilInformationScreen
                                  .eCouncilInformationPageInformationKey:
                              whatIsTheECouncil,
                        },
                      );
                    },
                    child: Text(
                      LocaleProvider.of(context).what_is_the_e_council,
                      style: textStyle,
                    ),
                  ),

                  //
                  R.widgets.hSizer16,

                  //? E-Konsey Nasil Kullanilir?
                  InkWell(
                    onTap: () {
                      Atom.to(
                        PagePaths.eCouncilInformationPage,
                        queryParameters: {
                          ECouncilInformationScreen
                                  .eCouncilInformationPageTitleKey:
                              LocaleProvider.of(context)
                                  .how_to_use_the_e_council,
                          ECouncilInformationScreen
                                  .eCouncilInformationPageInformationKey:
                              howToUseTheECouncil,
                        },
                      );
                    },
                    child: Text(
                      LocaleProvider.of(context).how_to_use_the_e_council,
                      style: textStyle,
                    ),
                  ),
                  R.widgets.hSizer24,
                  //? Konsey Taleplerim
                  const _BuildCustomExpansionTile(),
                  R.widgets.hSizer16,
                  //? Konsey Sonuçlarım
                  const _BuildCouncilResults(),
                  R.widgets.hSizer16,
                ],
              ),
            ),
          ),
          RbioElevatedButton(
            title: LocaleProvider.of(context).create_new_council_request,
            onTap: () {
              Atom.to(PagePaths.eCouncilCreateCouncilRequestPage);
            },
          ),
        ],
      ),
    );
  }
}

/// Konsey Sonuçlarım
class _BuildCouncilResults extends StatelessWidget {
  const _BuildCouncilResults({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.zero,
      shape: R.sizes.defaultShape,
      child: InkWell(
        onTap: () {
          Atom.to(PagePaths.eCouncilResultPage);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              SvgPicture.asset(R.image.councilResults),
              R.widgets.wSizer16,
              Text(LocaleProvider.of(context).council_results,
                  style: context.xHeadline2),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

/// E-Konsey Taleplerim
class _BuildCustomExpansionTile extends StatefulWidget {
  /// E-Konsey Taleplerim
  const _BuildCustomExpansionTile({Key? key}) : super(key: key);

  @override
  State<_BuildCustomExpansionTile> createState() =>
      _BuildCustomExpansionTileState();
}

class _BuildCustomExpansionTileState extends State<_BuildCustomExpansionTile> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.xCardColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              //! Animasyon  tasarim ekibi isteği üzerine iptal edildi.
              // setState(() {
              //   isExpanded = !isExpanded;
              // });
              Atom.to(PagePaths.eCouncilRequestPage);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    R.image.councilCalendar,
                    width: R.sizes.iconSize3,
                  ),
                  R.widgets.wSizer16,
                  //
                  Expanded(
                    child: Text(
                      LocaleProvider.of(context).council_requests,
                      style: context.xHeadline2,
                    ),
                  ),

                  //! Animasyon  tasarim ekibi isteği üzerine iptal edildi.
                  const Icon(Icons.arrow_forward_ios_outlined),
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_forward_ios_outlined),
                  //   onPressed: () {
                  // Atom.to(PagePaths.eCouncilRequestPage);
                  //   },
                  // ),
                ],
              ),
            ),
          ),

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: isExpanded,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 250),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //? Onay Bekleyen
                    _BuildECouncilListTile(
                      text: LocaleProvider.of(context).pending_approval,
                      color: context.xAppColors.boulder,
                      number: 2,
                    ),
                    //? Ödeme Bekleyen
                    _BuildECouncilListTile(
                      text: LocaleProvider.of(context).pending_payment,
                      color: context.xAppColors.supernova,
                      number: 0,
                    ),
                    //? Tetkik Bekleyen
                    _BuildECouncilListTile(
                      text: LocaleProvider.of(context).pending_inspection,
                      color: context.xAppColors.malibu,
                      number: 0,
                    ),
                    //? Reddedilen
                    _BuildECouncilListTile(
                      text: LocaleProvider.of(context).rejected,
                      color: context.xAppColors.punch,
                      number: 13,
                    ),
                    //? Randevu Hazır
                    _BuildECouncilListTile(
                      text: LocaleProvider.of(context).appointment_ready,
                      color: context.xAppColors.greenHaze,
                      number: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E-Konsey Taleplerim
class _BuildECouncilListTile extends StatelessWidget {
  /// E-Konsey Card List Tile
  const _BuildECouncilListTile({
    Key? key,
    required this.text,
    required this.color,
    required this.number,
  }) : super(key: key);

  final String text;
  final Color color;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, bottom: 8.0),
      child: Row(
        children: [
          //
          Text(
            text,
            // style: Theme.of(context).textTheme.headline3!.copyWith(color: color),
            style: context.xHeadline5.copyWith(color: color),
          ),

          //
          R.widgets.hSizer16,

          //
          const Spacer(),

          //
          Container(
            width: 18,
            height: 18,
            child: Center(
              child: Text(
                '$number',
                style: context.xHeadline5.copyWith(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          //
          const SizedBox(height: 15, width: 60),
        ],
      ),
    );
  }
}
