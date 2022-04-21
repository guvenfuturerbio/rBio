part of '../view/scale_patient_detail_screen.dart';

class _UserScaleDetailCard extends StatelessWidget {
  final PatientScaleMeasurement patientDetail;

  const _UserScaleDetailCard({
    Key? key,
    required this.patientDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.age,
              rightTitle: LocaleProvider.current.gender,
              topPadding: false,
            ),

            //æ
            _buildValueRow(
              context,
              leftValue: patientDetail.age?.toString() ?? "-",
              rightValue: patientDetail.genderId == 2
                  ? LocaleProvider.current.gender_female
                  : LocaleProvider.current.gender_male,
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.weight,
              rightTitle: LocaleProvider.current.height,
              topPadding: false,
            ),

            //æ
            _buildValueRow(
              context,
              leftValue: patientDetail.weight?.toStringAsFixed(2) ?? "-",
              rightValue: patientDetail.height?.toStringAsFixed(2) ?? "-",
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.scale_data_bmi,
              rightTitle: "BMH",
            ),
            _buildValueRow(
              context,
              leftValue: patientDetail.bmi?.toStringAsFixed(2) ?? "-",
              rightValue: patientDetail.bmh?.toStringAsFixed(2) ?? "-",
            ),
            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.scale_data_muscle,
              rightTitle: LocaleProvider.current.scale_data_body_fat,
            ),

            _buildValueRow(
              context,
              leftValue: patientDetail.muscle?.toStringAsFixed(2) ?? "-",
              rightValue: patientDetail.bodyFat?.toStringAsFixed(2) ?? "-",
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.scale_data_visceral_fat,
              rightTitle: LocaleProvider.current.scale_data_bone_mass,
            ),

            _buildValueRow(
              context,
              leftValue: patientDetail.visceralFat?.toStringAsFixed(2) ?? "-",
              rightValue: patientDetail.boneMass?.toStringAsFixed(2) ?? "-",
            ),
            //
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(
    BuildContext context, {
    required String leftTitle,
    required String rightTitle,
    bool topPadding = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ? 5 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //
          Expanded(
            child: Text(
              leftTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                color: getIt<ITheme>().textColorPassive,
              ),
            ),
          ),

          //
          Expanded(
            child: Text(
              rightTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                color: getIt<ITheme>().textColorPassive,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueRow(BuildContext context,
      {required String leftValue,
      required String rightValue,
      VoidCallback? rightOnTap}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //
        Expanded(
          child: Text(
            leftValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline5,
          ),
        ),

        //
        Expanded(
          child: InkWell(
            onTap: rightOnTap,
            child: Text(
              rightValue,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5,
            ),
          ),
        ),
      ],
    );
  }
}
