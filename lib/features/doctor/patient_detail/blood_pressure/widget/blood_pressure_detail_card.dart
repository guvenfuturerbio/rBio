part of '../view/bp_patient_detail_screen.dart';

class _UserBloodPressureDetailCard extends StatelessWidget {
  final BloodPressureModel? patientDetail;

  const _UserBloodPressureDetailCard({
    Key? key,
    required this.patientDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.xCardColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: patientDetail == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  LocaleProvider.current.not_found,
                  style: TextStyle(
                    color: context.xMyCustomTheme.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //
                  _buildTitleRow(
                    context,
                    leftTitle: LocaleProvider.current.manuel,
                    rightTitle: LocaleProvider.current.date,
                    topPadding: false,
                  ),

                  //æ
                  _buildValueRow(context,
                      leftValue: (patientDetail?.isManual ?? false) ? "M" : "D",
                      rightValue:
                          patientDetail?.dateTime?.xFormatTime1() ?? ""),

                  //
                  _buildTitleRow(
                    context,
                    leftTitle: LocaleProvider.current.dia,
                    rightTitle: LocaleProvider.current.sys,
                    topPadding: false,
                  ),

                  //æ
                  _buildValueRow(
                    context,
                    leftValue: patientDetail?.dia?.toString() ?? "-",
                    rightValue: patientDetail?.sys?.toString() ?? "-",
                  ),

                  //
                  _buildTitleRow(
                    context,
                    leftTitle: LocaleProvider.current.pulse,
                    rightTitle: " ",
                  ),
                  _buildValueRow(
                    context,
                    leftValue: patientDetail?.pulse?.toString() ?? "-",
                    rightValue: " ",
                  ),
                  //
                  _buildTitleRow(
                    context,
                    leftTitle: LocaleProvider.current.notes,
                    rightTitle: " ",
                  ),
                  _buildValueRow(
                    context,
                    leftValue: patientDetail?.note == ""
                        ? "-"
                        : patientDetail?.note ?? "-",
                    rightValue: " ",
                  ),
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
                color: context.xMyCustomTheme.textDisabledColor,
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
                color: context.xMyCustomTheme.textDisabledColor,
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
