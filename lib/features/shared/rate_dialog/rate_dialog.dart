import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'rate_dialog_vm.dart';

class RateDialog extends StatefulWidget {
  final int availabilityId;

  const RateDialog({Key? key, required this.availabilityId}) : super(key: key);

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(
        LocaleProvider.current.rate_appointment,
      ),
      content: ChangeNotifierProvider(
        create: (context) => RateDialogVm(
          context: context,
          availabilityId: widget.availabilityId,
        ),
        child: Consumer<RateDialogVm>(
          builder: (context, value, child) {
            textEditingController.text =
                value.getAvailabilityRateResponse?.suggestion ?? "";
            textEditingController.selection = TextSelection.collapsed(
              offset:
                  value.getAvailabilityRateResponse?.suggestion?.length ?? 0,
            );

            return RbioLoadingOverlay(
              isLoading: value.showLoadingOverLay ?? false,
              progressIndicator: const RbioLoading(),
              opacity: 0,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GuvenAlert.buildDescription(
                        LocaleProvider.current.how_video_quality,
                      ),

                      //
                      RatingBar.builder(
                        initialRating: value.getAvailabilityRateResponse
                                ?.videoConferanceRate
                                ?.toDouble() ??
                            1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: getIt<ITheme>().mainColor,
                        ),
                        onRatingUpdate: (rating) {
                          value.setVideoQuality(rating.toInt());
                        },
                      ),

                      //
                      GuvenAlert.buildDescription(
                        LocaleProvider.current.video_call_legand,
                      ),

                      //
                      const SizedBox(
                        height: 10,
                      ),

                      //
                      GuvenAlert.buildSmallDescription(
                        LocaleProvider.current.how_video_doctor,
                      ),

                      //
                      RatingBar.builder(
                        initialRating: value
                                .getAvailabilityRateResponse?.doctorRate
                                ?.toDouble() ??
                            1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: getIt<ITheme>().mainColor,
                        ),
                        onRatingUpdate: (rating) {
                          value.setDoctorQuality(rating.toInt());
                        },
                      ),

                      //
                      GuvenAlert.buildSmallDescription(
                        LocaleProvider.current.doctor_legand,
                      ),

                      //
                      const SizedBox(
                        height: 10,
                      ),

                      //
                      TextField(
                        controller: textEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(color: Colors.black),
                        maxLength: 256,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 12, right: 12),
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          labelText: LocaleProvider.of(context)
                              .comments_and_suggestion,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            //  when the TextFormField in focused
                          ),
                          border: const UnderlineInputBorder(),
                        ),
                      ),

                      //
                      const SizedBox(height: 10),

                      //
                      Utils.instance.button(
                        text: LocaleProvider.current.save,
                        onPressed: () {
                          value.rateAppointment(textEditingController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
