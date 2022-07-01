import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/rate_dialog_vm.dart';

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
    return RbioBaseDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: Text(
                  LocaleProvider.of(context).rate_appointment,
                  style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            R.sizes.hSizer32,
            ChangeNotifierProvider(
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
                        value.getAvailabilityRateResponse?.suggestion?.length ??
                            0,
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
                            Text(
                              LocaleProvider.current.how_video_quality,
                              style: getIt<IAppConfig>()
                                  .theme
                                  .dialogTheme
                                  .description(context),
                              textAlign: TextAlign.center,
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
                                color: getIt<IAppConfig>().theme.mainColor,
                              ),
                              onRatingUpdate: (rating) {
                                value.setVideoQuality(rating.toInt());
                              },
                            ),

                            //
                            Text(
                              LocaleProvider.current.video_call_legand,
                              style: getIt<IAppConfig>()
                                  .theme
                                  .dialogTheme
                                  .subTitle(context),
                              textAlign: TextAlign.center,
                            ),

                            //
                            const SizedBox(
                              height: 10,
                            ),

                            //
                            Text(
                              LocaleProvider.current.how_video_doctor,
                              style: getIt<IAppConfig>()
                                  .theme
                                  .dialogTheme
                                  .description(context),
                              textAlign: TextAlign.center,
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
                                color: getIt<IAppConfig>().theme.mainColor,
                              ),
                              onRatingUpdate: (rating) {
                                value.setDoctorQuality(rating.toInt());
                              },
                            ),

                            //
                            Text(
                              LocaleProvider.current.doctor_legand,
                              style: getIt<IAppConfig>()
                                  .theme
                                  .dialogTheme
                                  .subTitle(context),
                              textAlign: TextAlign.center,
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
                            RbioSmallDialogButton.green(
                              title: LocaleProvider.current.save,
                              onPressed: () {
                                value.rateAppointment(
                                    textEditingController.text);
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
          ],
        ),
      ),
    );
  }
}
