import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:onedosehealth/core/widgets/guven_alert.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import 'rate_dialog_vm.dart';

class RateDialog extends StatefulWidget {
  final int availabilityId;

  const RateDialog({this.availabilityId});

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: R.color.white,
      title: Text(
        LocaleProvider.current.rate_appointment,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: ChangeNotifierProvider(
        create: (context) => RateDialogVm(
            context: context, availabilityId: widget.availabilityId),
        child: Consumer<RateDialogVm>(builder: (context, value, child) {
          textEditingController.text =
              value?.getAvailabilityRateResponse?.suggestion ?? "";
          textEditingController.selection = TextSelection.collapsed(
              offset:
                  value?.getAvailabilityRateResponse?.suggestion?.length ?? 0);
          return LoadingOverlay(
            isLoading: value.showLoadingOverlay,
            progressIndicator: loadingDialog(),
            opacity: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LocaleProvider.current.how_video_quality,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RatingBar.builder(
                      initialRating: value
                              ?.getAvailabilityRateResponse?.videoConferanceRate
                              ?.toDouble() ??
                          1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: R.color.blue,
                      ),
                      onRatingUpdate: (rating) {
                        value.setVideoQuality(rating.toInt());
                      },
                    ),
                    Text(
                      LocaleProvider.current.video_call_legand,
                      style: TextStyle(fontSize: 8),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      LocaleProvider.current.how_video_doctor,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RatingBar.builder(
                      initialRating: value
                              ?.getAvailabilityRateResponse?.doctorRate
                              ?.toDouble() ??
                          1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: R.color.blue,
                      ),
                      onRatingUpdate: (rating) {
                        value.setDoctorQuality(rating.toInt());
                      },
                    ),
                    Text(
                      LocaleProvider.current.doctor_legand,
                      style: TextStyle(fontSize: 8),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black),
                      maxLength: 256,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: LocaleProvider.of(context)
                              .comments_and_suggestion,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  when the TextFormField in focused
                          ),
                          border: UnderlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    button(
                        text: LocaleProvider.current.save,
                        onPressed: () {
                          value.rateAppointment(textEditingController.text);
                        })
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
