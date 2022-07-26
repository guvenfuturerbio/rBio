part of '../view/bg_patient_detail_screen.dart';

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
                  getTagState(context, data.tag!),
                  getNote(data.note!),
                  getAction(context, () => Navigator.of(context).pop())
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
    var level = double.parse((data.result == '' ? '0' : data.result)!).toInt();

    return Container(
      height: 130 * context.textScale,
      width: 130 * context.textScale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Utils.instance.getGlucoseMeasurementColor(context, level),
        border: Border.all(
          color: Utils.instance.getGlucoseMeasurementColor(context, level),
          width: 5.0,
        ),
      ),
      child: boxInsideSection(context, true),
    );
  }

  Widget getCircleBg(BuildContext context) {
    var level = double.parse((data.result == '' ? '0' : data.result)!).toInt();

    return Container(
      alignment: Alignment.center,
      width: 130 * context.textScale,
      height: 130 * context.textScale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: data.tag == 2
            ? Utils.instance.getGlucoseMeasurementColor(context, level)
            : Colors.white,
        border: Border.all(
          color: Utils.instance.getGlucoseMeasurementColor(context, level),
          width: 10.0,
        ),
      ),
      child: boxInsideSection(context, data.tag == 2),
    );
  }

  Widget boxInsideSection(BuildContext context, bool isFill) {
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
        color: isFill ? Colors.white : Colors.black,
      ),
    );
  }
  // InputSection #end

  // DateTimePickerSection #start
  Widget getDateTimePicker(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Card(
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

  Widget readableDateTime(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //
        Expanded(
          flex: 2,
          child: Text(date.xGetReadableDate),
        ),

        //
        Expanded(
          child: Text(date.xGetReadableHour),
        )
      ],
    );
  }
  // DateTimePickerSection #end

  // TagSection #begin
  Widget getTagState(
    BuildContext context,
    int currentTag,
  ) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        getTagElement(
          context,
          currentTag == 1,
          R.image.beforeMealIconBlack,
          LocaleProvider.current.hungry,
        ),
        getTagElement(
          context,
          currentTag == 2,
          R.image.aftermealIconBlack,
          LocaleProvider.current.full,
        ),
        getTagElement(
          context,
          currentTag == 3,
          R.image.otherIcon,
          LocaleProvider.current.other,
        ),
      ],
    );
  }

  Widget getTagElement(
    BuildContext context,
    bool isCurrent,
    String icon,
    String title,
  ) {
    return Card(
      color: isCurrent ? context.xPrimaryColor : context.xCurrentTheme.white,
      child: Container(
        decoration: getTagElementDeco(context, isCurrent),
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

  BoxDecoration getTagElementDeco(BuildContext context, bool isCurrent) {
    return BoxDecoration(
      borderRadius: R.sizes.borderRadiusCircular,
      color: isCurrent ? context.xPrimaryColor : Colors.white,
    );
  }
  // TagSection #end

  Widget getNote(String note) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: 120,
      width: double.infinity,
      child: Card(
        child: Center(
          child: Text(
            note,
          ),
        ),
      ),
    );
  }

  Widget getAction(BuildContext context, VoidCallback action) {
    return Wrap(
      children: [
        GestureDetector(onTap: action, child: actionButton(context)),
      ],
    );
  }

  Widget actionButton(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: R.sizes.borderRadiusCircular,
          color: context.xPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
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
