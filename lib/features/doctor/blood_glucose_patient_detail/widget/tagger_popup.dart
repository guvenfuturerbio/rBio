part of '../view/blood_glucose_patient_detail_screen.dart';

class _TaggerPopUp extends StatelessWidget {
  final BgMeasurementViewModel data;

  const _TaggerPopUp({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SingleChildScrollView(
              child: Column(
                key: const Key('bgTagger'),
                children: [
                  data.tag == 3 || data.tag == null
                      ? getSquareBg(context)
                      : getCircleBg(context),
                  getDateTimePicker(context, data.date),
                  getTagState(data.tag!),
                  getNote(data.note!),
                  getAction(() => Navigator.of(context).pop())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // InputSection #start
  Widget getSquareBg(BuildContext context) {
    var level = int.parse((data.result == '' ? '0' : data.result)!);
    return Container(
      height: 130 * context.textScale,
      width: 130 * context.textScale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: UtilityManager().getGlucoseMeasurementColor(level),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(level),
          width: 5.0,
        ),
      ),
      child: boxInsideSection(context, true),
    );
  }

  Widget getCircleBg(BuildContext context) {
    var level = int.parse((data.result == '' ? '0' : data.result)!);

    return Container(
      alignment: Alignment.center,
      width: 130 * context.textScale,
      height: 130 * context.textScale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: data.tag == 2
            ? UtilityManager().getGlucoseMeasurementColor(level)
            : Colors.white,
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(level),
          width: 10.0,
        ),
      ),
      child: boxInsideSection(context, data.tag == 2),
    );
  }

  Padding boxInsideSection(BuildContext context, bool isFill) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: getBgInputWidget(isFill),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "mg/dL",
          ),
        ],
      ),
    );
  }

  Widget getBgInputWidget(bool isFill) {
    return Text(
      data.result!,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: isFill ? Colors.white : Colors.black),
    );
  }
  // InputSection #end

  // DateTimePickerSection #start
  Widget getDateTimePicker(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        color: R.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 10,
          ),
          child: readableDateTime(date),
        ),
      ),
    );
  }

  Row readableDateTime(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(UtilityManager().getReadableDate(date)),
        ),
        Expanded(
          child: Text(UtilityManager().getReadableHour(date)),
        )
      ],
    );
  }
  // DateTimePickerSection #end

  // TagSection #begin
  Wrap getTagState(int currentTag) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        getTagElement(
          currentTag == 1,
          R.image.beforeMealIconBlack,
          LocaleProvider.current.hungry,
        ),
        getTagElement(
          currentTag == 2,
          R.image.aftermealIconBlack,
          LocaleProvider.current.full,
        ),
        getTagElement(
          currentTag == 3,
          R.image.otherIcon,
          LocaleProvider.current.other,
        ),
      ],
    );
  }

  Widget getTagElement(bool isCurrent, String icon, String title) {
    return Card(
      elevation: R.sizes.defaultElevation,
      color: isCurrent ? R.color.btnDarkBlue : R.color.white,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        decoration: getTagElementDeco(isCurrent),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                icon,
                color: isCurrent ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(color: isCurrent ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration getTagElementDeco(bool isCurrent) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: isCurrent
            ? <Color>[R.color.btnLightBlue, R.color.btnDarkBlue]
            : <Color>[Colors.white, Colors.white],
      ),
    );
  }
  // TagSection #end

  Widget getNote(String note) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: 120,
      width: double.infinity,
      child: Card(
        elevation: R.sizes.defaultElevation,
        color: R.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Center(
          child: Text(
            note,
          ),
        ),
      ),
    );
  }

  Widget getAction(VoidCallback action) {
    return Wrap(
      children: [
        GestureDetector(onTap: action, child: actionButton()),
      ],
    );
  }

  Widget actionButton() {
    return Card(
      elevation: R.sizes.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: <Color>[R.color.btnLightBlue, R.color.btnDarkBlue]),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          LocaleProvider.current.done,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
