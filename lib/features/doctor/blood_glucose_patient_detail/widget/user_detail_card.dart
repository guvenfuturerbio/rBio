part of '../view/blood_glucose_patient_detail_screen.dart';

class _UserDetailCard extends StatelessWidget {
  final DoctorPatientDetailModel patientDetail;
  final VoidCallback targetRangePresses;
  final VoidCallback hypoEdit;
  final VoidCallback hyperEdit;

  const _UserDetailCard({
    Key key,
    @required this.patientDetail,
    @required this.targetRangePresses,
    @required this.hypoEdit,
    @required this.hyperEdit,
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
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.identity_passport,
              rightTitle: LocaleProvider.current.date_of_birth,
              topPadding: false,
            ),
            _buildValueRow(
              context,
              leftValue: '1234678909',
              rightValue: patientDetail?.birthDay ?? "-",
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.diabet_type,
              rightTitle: LocaleProvider.current.height,
            ),
            _buildValueRow(
              context,
              leftValue: patientDetail?.diabetType?.name ?? "-",
              rightValue: patientDetail?.height ?? "-",
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.normal_range,
              rightTitle: LocaleProvider.current.weight,
            ),
            _buildEditableValueRow(
              context,
              leftValue: (patientDetail?.rangeMin ?? "").toString() +
                  "-" +
                  (patientDetail?.rangeMax ?? "").toString() +
                  (" mg/dL"),
              rightValue: patientDetail?.weight ?? "-",
              onTap: () {
                targetRangePresses();
              },
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.hypo,
              rightTitle: LocaleProvider.current.last_hba1c,
            ),
            _buildEditableValueRow(
              context,
              leftValue: (patientDetail?.hypo ?? "-").toString() + " mg/dL",
              rightValue: "-",
              onTap: () {
                hypoEdit();
              },
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.hyper,
              rightTitle: LocaleProvider.current.year_of_diagnosis,
            ),
            _buildEditableValueRow(
              context,
              leftValue: (patientDetail?.hyper ?? "-").toString() + " mg/dL",
              rightValue: (patientDetail?.yearOfDiagnosis ?? "-").toString(),
              onTap: () {
                hyperEdit();
              },
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.medicines,
              rightTitle: LocaleProvider.current.smoking,
            ),
            _buildValueRow(
              context,
              leftValue: "-",
              rightValue: patientDetail?.smoker != null
                  ? patientDetail.smoker
                      ? LocaleProvider.current.yes
                      : LocaleProvider.current.no
                  : "-",
            ),

            //
            _buildTitleRow(
              context,
              leftTitle: LocaleProvider.current.strip_number_2,
              rightTitle: '',
            ),
            _buildValueRow(
              context,
              leftValue: "200",
              rightValue: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(
    BuildContext context, {
    @required String leftTitle,
    @required String rightTitle,
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

  Widget _buildValueRow(
    BuildContext context, {
    @required String leftValue,
    @required String rightValue,
  }) {
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
          child: Text(
            rightValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline5,
          ),
        ),
      ],
    );
  }

  Widget _buildEditableValueRow(
    BuildContext context, {
    @required String leftValue,
    @required String rightValue,
    @required void Function() onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  leftValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline5,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: onTap,
                child: SvgPicture.asset(
                  R.image.other,
                  color: R.color.mainColor,
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
        ),

        //
        Expanded(
          child: Text(
            rightValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline5,
          ),
        ),
      ],
    );
  }
}
