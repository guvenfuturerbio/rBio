import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: KeyboardDismissOnTap(
        child: RbioKeyboardActions(
          isDialog: true,
          focusList: [
            _focusNode,
          ],
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
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
                      style:
                          getIt<IAppConfig>().theme.dialogTheme.title(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                //
                R.widgets.hSizer32,

                //
                ChangeNotifierProvider(
                  create: (context) => RateDialogVm(
                    context: context,
                    availabilityId: widget.availabilityId,
                  ),
                  child: Consumer<RateDialogVm>(
                    builder: (context, value, child) {
                      if (!value.firstLoad) {
                        _textEditingController.text =
                            value.getAvailabilityRateResponse?.suggestion ?? "";
                        _textEditingController.selection =
                            TextSelection.collapsed(
                          offset: value.getAvailabilityRateResponse?.suggestion
                                  ?.length ??
                              0,
                        );
                      }

                      return RbioLoadingOverlay(
                        isLoading: value.showLoadingOverLay ?? false,
                        progressIndicator: const RbioLoading(),
                        opacity: 0,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
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
                                  initialRating: value
                                          .getAvailabilityRateResponse
                                          ?.videoConferanceRate
                                          ?.toDouble() ??
                                      1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                                          .getAvailabilityRateResponse
                                          ?.doctorRate
                                          ?.toDouble() ??
                                      1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                                RbioTextFormField(
                                  focusNode: _focusNode,
                                  controller: _textEditingController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 256,
                                  hintText: LocaleProvider.of(context)
                                      .comments_and_suggestion,
                                  backColor:
                                      getIt<IAppConfig>().theme.grayColor,
                                ),

                                //
                                const SizedBox(height: 10),

                                //
                                RbioSmallDialogButton.green(
                                  title: LocaleProvider.current.save,
                                  onPressed: () {
                                    value.rateAppointment(
                                      _textEditingController.text.trim(),
                                    );
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
        ),
      ),
    );
  }
}
