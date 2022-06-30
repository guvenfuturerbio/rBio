// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

class ECouncilResultScreen extends StatelessWidget {
  const ECouncilResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getIt<IAppConfig>().theme.eCouncilScafoldBackground,
      appBar: RbioAppBar(title: Text(LocaleProvider.of(context).council_results)),
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      children: const [
        _BuildCouncilReportCard(
          diagnosis: 'Bel Ağrısı',
          departmentManager: "Prof. Dr. Ismet Ozel",
          date: '21.06.2022',
        ),
        _BuildCouncilReportCard(
          diagnosis: 'Bel Ağrısı',
          departmentManager: "Prof. Dr. Ismet Ozel",
          date: '21.06.2022',
        ),
      ],
    );
  }
}

class _BuildCouncilReportCard extends StatelessWidget {
  const _BuildCouncilReportCard({
    Key? key,
    required this.diagnosis,
    required this.departmentManager,
    required this.date,
  }) : super(key: key);

  final String diagnosis;
  final String departmentManager;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //? Title
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: getIt<IAppConfig>().theme.eCouncilResultCardTitleBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(LocaleProvider.of(context).council_report, style: context.xHeadline3),
                ],
              ),
            ),
          ),
          //? Body
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(left: 15.0, top: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? Teşhis
                Text(
                  LocaleProvider.of(context).diagnosis,
                  style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
                ),
                Text(diagnosis, style: context.xSubtitle2),
                //? Bölüm Sorumlusu
                const SizedBox(height: 8),
                Text(
                  LocaleProvider.of(context).department_manager,
                  style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
                ),
                Text(departmentManager, style: context.xSubtitle2),
                //? Tarih
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleProvider.of(context).date,
                          style: context.xSubtitle2.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
                        ),
                        Text(date, style: context.xSubtitle2),
                      ],
                    ),
                    const Spacer(),
                    RbioElevatedButton(
                      title: LocaleProvider.of(context).show,
                      padding: EdgeInsets.zero,
                      onTap: () {},
                    ),
                    const SizedBox(width: 15),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
